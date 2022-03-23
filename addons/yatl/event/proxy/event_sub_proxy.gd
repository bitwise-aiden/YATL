extends Node

# Private imports

const __HTTPServer: Resource = preload("./http_server/http_server.gd")
const __PAL: Resource = preload("../../pal/pal.gd")


# Private variables

var __pal: __PAL
var __server: __HTTPServer

var __ngrok_url: String = ""

var __subscriptions: Dictionary = {}


# Lifecycle methods

func _init(_pal: __PAL) -> void:
	__pal = _pal


func _ready() -> void:
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

	if __server == null:
		__start_server()

	__process_connections()


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

	var subscription = __subscriptions.get(transport.get("id"))

	if subscription == null:
		_response.status(404)
		_response.data("huh? I don't know a websocket with the ID %s" % transport.get("id"))

		return


func __handle_websocket(
	_request: __HTTPServer.Request,
	_response: __HTTPServer.Response
) -> void:
	pass


func __process_connections() -> void:
	if __server == null:
		return

	__server.take_connection()


func __start_server(port: int = 25708) -> void:
	__server = __HTTPServer.new()

	__server.endpoint(
		__HTTPServer.Method.POST,
		"/helix/eventsub/subscriptions",
		funcref(self, "__handle_subscription")
	)

	__server.endpoint(
		__HTTPServer.Method.POST,
		"/helix/eventsub/websockets",
		funcref(self, "__handle_websocket")
	)

	__server.listen(port)

