extends Node

# Private classes

class __Connection:
	# Private variables

	var __id: int
	var __peer: PacketPeer
	var __subscriptions: Array

	# Lifecycle methods

	func _init(id: int, _peer: PacketPeer) -> void:
		__id = id
		__peer = _peer
		__subscriptions = []


	# Public methods

	func is_subscribed(_type: String) -> bool:
		return __subscriptions.find(_type) != -1


	func keep_alive() -> void:
		var payload: Dictionary = {
			"id": str(__id),
			"status": "connected",
			"minimum_message_frequency_seconds": 10,
			"connected_at": "",
		}

		send_message("websocket_keepalive", payload)


	func send_message(_type: String, _data: Dictionary) -> void:
		var message: Dictionary = {
			"metadata": {
				"message_id": "",
				"message_type": _type,
				"message_timestamp": "",
			},
			"payload": _data,
		}

		__peer.put_packet(to_json(message).to_utf8())


	func send_data(_data: Dictionary) -> void:
		__peer.put_packet(to_json(_data).to_utf8())


	func subscribe(_type: String) -> void:
		__remove(_type)

		__subscriptions.append(_type)


	# Private methods

	func __remove(_type: String) -> void:
		var index: int = __subscriptions.find(_type)

		if index != -1:
			__subscriptions.remove(index)

# Private imports

const __HTTPServer: Resource = preload("./http_server/http_server.gd")
const __PAL: Resource = preload("../../pal/pal.gd")


# Private variables

var __timer: Timer = Timer.new()

var __pal: __PAL
var __http_server: __HTTPServer
var __web_socket: WebSocketServer

var __ngrok_url: String = ""

var __connections: Dictionary = {
	# key: int - connection id
	# value: __Connection
}


# Lifecycle methods

func _init(_pal: __PAL) -> void:
	__pal = _pal


func _ready() -> void:
	add_child(__timer)

	__timer.wait_time = 3.0
	__timer.one_shot = false
	__timer.connect("timeout", self, "__keep_alive")

	__timer.start()

	var response: __PAL.HTTPResponse = yield(
		__pal.request("http://127.0.0.1:4040/api/tunnels"),
		"completed"
	)

	if response.status_code != 200:
		push_error("ngrok not active. Please start then restart this application")
		queue_free()
		return

	var data: Dictionary = parse_json(response.body)

	__ngrok_url = data \
		.get('tunnels')[0] \
		.get('public_url') \
		.replace("http://", "https://")


func _process(delta: float) -> void:
	if !__ngrok_url:
		return

	if __http_server == null:
		__start_server()

	__process_http_connections()

	if __web_socket == null:
		__start_websocket()

	__process_socket_connections()


# Private methods

func __handle_notification(
	_request: __HTTPServer.Request,
	_response: __HTTPServer.Response
) -> void:
	var connection_id: String = _request.endpoint().split("/", false)[1]
	var type: String = _request.header("twitch-eventsub-message-type", "")
	var body: Dictionary = _request.json()

	if !__connections.has(int(connection_id)):
		# TODO: The connection no longer exists
		return

	var connection: __Connection = __connections.get(int(connection_id))

	match type:
		"webhook_callback_verification":
			var notification_type: String = _request.header("twitch-eventsub-subscription-type", "")

			connection.subscribe(notification_type)
			print("connected - id: %s, event: %s" % [connection_id, notification_type])

			_response.data(body.get("challenge"))
		"notification":
			var notification_type: String = _request.header("twitch-eventsub-subscription-type", "")

			if !connection.is_subscribed(notification_type):
				# TODO: The connection isn't subscribed to the incoming event
				return

			var payload: Dictionary = {
				"metadata": {},
				"payload": body,
			}

			for header in _request.headers():
				if !header.begins_with("twitch-eventsub"):
					continue

				var formatted_header: String = header \
					.replace("twitch-eventsub-", "") \
					.replace("-", "_")

				payload["metadata"][formatted_header] = _request.header(header)

			connection.send_data(payload)


func __handle_subscription(
	_request: __HTTPServer.Request,
	_response: __HTTPServer.Response
) -> void:
	var client_id: String = _request.header("client-id")
	var authorization: String = _request.header("authorization")

	if client_id == null || authorization == null:
		_response.status(403)
		_response.data("Missing client-id or authorization header.")

		return

	var body: Dictionary = _request.json()
	var transport: Dictionary = body.get("transport")

	if !__connections.has(int(transport.get("id"))):
		_response.status(404)
		_response.data("huh? I don't know a websocket with the ID %s" % transport.get("id"))

		return

	body["transport"] = {
		"method": "webhook",
		"callback": "%s/notification/%s" % [__ngrok_url, transport.get("id")],
		"secret": "lumikkode_is_the_best",
	}

	var response: __PAL.HTTPResponse = yield(
		__pal.request(
			"https://api.twitch.tv/helix/eventsub/subscriptions",
			{
				"headers": {
					"client-id": client_id,
					"authorization": authorization,
					"content-type": "application/json",
				},
				"data": body,
				"method": HTTPClient.METHOD_POST,
			}
		),
		"completed"
	)


func __handle_websocket(
	_request: __HTTPServer.Request,
	_response: __HTTPServer.Response
) -> void:
	pass


func __process_http_connections() -> void:
	if __http_server == null:
		return

	__http_server.take_connection()


func __process_socket_connections() -> void:
	if __web_socket == null:
		return

	__web_socket.poll()


func __start_server(port: int = 25707) -> void:
	__http_server = __HTTPServer.new()

	__http_server.endpoint(
		__HTTPServer.Method.POST,
		"/helix/eventsub/subscriptions",
		funcref(self, "__handle_subscription")
	)

	__http_server.endpoint(
		__HTTPServer.Method.POST,
		"/helix/eventsub/websockets",
		funcref(self, "__handle_websocket")
	)

	__http_server.endpoint(
		__HTTPServer.Method.POST,
		"/notification",
		funcref(self, "__handle_notification")
	)

	__http_server.listen(port)


func __start_websocket(port: int = 25708) -> void:
	__web_socket = WebSocketServer.new()

	__web_socket.connect("client_close_request", self, "__web_socket_close_request")
	__web_socket.connect("client_connected", self, "__web_socket_connected")
	__web_socket.connect("client_disconnected", self, "__web_socket_disconnected")
	__web_socket.connect("data_received", self, "__web_socket_data_received")

	__web_socket.listen(port)


func __web_socket_close_request(id: int, code: int, reason: String) -> void:
	__connections.erase(id)


func __web_socket_connected(id: int, protocol: String) -> void:
	var peer: PacketPeer = __web_socket.get_peer(id)

	__connections[id] = __Connection.new(id, peer)

	var payload: Dictionary = {
		"websocket": {
			"id": str(id),
			"status": "connected",
			"minimum_message_frequency_seconds": 10,
			"connected_at": "",
		},
	}

	__connections[id].send_message("websocket_welcome", payload)


func __web_socket_disconnected(id: int, was_clean_close: bool) -> void:
	__connections.erase(id)


func __web_socket_data_received(id: int) -> void:
	var payload: Dictionary = {
		"websocket": {
			"id": str(id),
			"status": "disconnected",
			"disconnect_reason": "client_sent_inbound_traffic",
			"minimum_message_frequency_seconds": 10,
			"connected_at": "",
			"disconnected_at": "",
		},
	}

	__connections[id].send_message("websocket_disconnect", payload)

	__web_socket.disconnect_peer(id)
	__connections.erase(id)


func __keep_alive() -> void:
	if __web_socket == null:
		return

	for connection_id in __connections:
		var connection: __Connection = __connections[connection_id]
		connection.keep_alive()

