extends Node

# Private imports

const __HTTPServer: Resource = preload("./http_server/http_server.gd")
const __PAL: Resource = preload("../../pal/pal.gd")


# Private variables

var __timer: Timer = Timer.new()

var __pal: __PAL
var __http_server: __HTTPServer
var __web_socket: WebSocketServer

var __ngrok_url: String = ""

var __subscriptions: Dictionary = {}

var __connections: Dictionary = {
	# key: int - connection id
	# value: PacketPeer
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

	var response: __PAL.HTTPResponse = __pal.request(
		"http://127.0.0.1:4040/api/tunnels",
		{},
		false
	)

	response = yield(response, "completed")

	if response.response_code != 200:
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

	var connection =  __connections.get(int(transport.get("id")))

	if connection == null:
		_response.status(404)
		_response.data("huh? I don't know a websocket with the ID %s" % transport.get("id"))

		return

	# Translate transport data
	# Send request to actual twitch
	# Store response data


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

	__connections[id] = peer

	var payload: Dictionary = {
		"websocket": {
			"id": str(id),
			"status": "connected",
			"minimum_message_frequency_seconds": 10,
			"connected_at": "",
		},
	}

	peer.put_packet(__message("websocket_welcome", payload))


func __web_socket_disconnected(id: int, was_clean_close: bool) -> void:
	__connections.erase(id)


func __web_socket_data_received(id: int) -> void:
	var peer: PacketPeer = __web_socket.get_peer(id)

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

	__connections[id].put_packet(__message("websocket_disconnect", payload))

	__web_socket.disconnect_peer(id)
	__connections.erase(id)


static func __message(type: String, payload: Dictionary) -> PoolByteArray:
	var message: Dictionary = {
		"metadata": {
			"message_id": "",
			"message_type": type,
			"message_timestamp": "",
		},
		"payload": payload,
	}

	return to_json(message).to_utf8()


func __keep_alive() -> void:
	if __web_socket == null:
		return

	for connection in __connections:
		var peer: PacketPeer = __connections[connection]

		var payload: Dictionary = {
			"id": str(connection),
			"status": "connected",
			"minimum_message_frequency_seconds": 10,
			"connected_at": "",
		}

		peer.put_packet(__message("websocket_keepalive", payload))
