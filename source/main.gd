extends Control

const RequestFactory = preload("res://addons/yatl/pal/factories/request_factory.gd")
const WebSocketFactory = preload("res://addons/yatl/pal/factories/web_socket_factory.gd")


func _ready() -> void:
	var request_factory: RequestFactory = RequestFactory.new()
	add_child(request_factory)

	var a = yield(request_factory.request("https://httpstat.us/200"), "completed")
	print(a.response_code)

	var b = yield(request_factory.request("https://httpstat.us/400"), "completed")
	print(b.response_code)

	var web_socket_factory: WebSocketFactory = WebSocketFactory.new()
	add_child(web_socket_factory)

	var c = yield(web_socket_factory.establish_connection("ws://test.we:8000"), "completed")
	print(c.connected)
