# Public signals

signal completed(response)


# Private variables

var request: HTTPRequest

var error: int setget __noop_set # Error
var result: int setget __noop_set # HTTPRequest Result
var response_code: int setget __noop_set
var headers: Dictionary setget __noop_set
var body: String setget __noop_set


# Lifecycle methods

func _init(
	_request: HTTPRequest
) -> void:
	request = _request

	request.connect("request_completed", self, "__request_completed")


# Private methods

func __noop_set(
	_value # Variant
) -> void:
	pass


func __request_completed(
	_result: int,
	_response_code: int,
	_headers: PoolStringArray,
	_body: PoolByteArray
) -> void:
	result = _result
	response_code = _response_code
	headers = {}

	for header in _headers:
		var parts: Array = header.split(":")

		var name: String = parts[0].trim_prefix(" ").trim_suffix(" ")
		var value: String = parts[1].trim_prefix(" ").trim_suffix(" ")

		headers[name] = value

	body = _body.get_string_from_utf8()

	request.queue_free()

	emit_signal("completed", self)



func __request_error(
	_error: int,
	tree: SceneTree
) -> void: # Friend: RequestFactory
	error = _error

	request.queue_free()

	yield(tree, "idle_frame")

	emit_signal("completed", self)
