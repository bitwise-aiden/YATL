extends Control

const RequestFactory = preload("res://addons/yatl/pal/request_factory.gd")


func _ready() -> void:
	var request_factory: RequestFactory = RequestFactory.new()
	add_child(request_factory)

	var a = yield(request_factory.request("https://httpstat.us/200"), "completed")
	print(a.response_code)

	var b = yield(request_factory.request("https://httpstat.us/400"), "completed")
	print(b.response_code)
