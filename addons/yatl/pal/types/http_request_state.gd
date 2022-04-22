# Private imports

const __HTTPResponse = preload("./http_response.gd")


# Public signals

signal completed(response)


# Public variables

var completed: bool setget __noop_set
var error: int setget __noop_set
var request: HTTPRequest setget __noop_set
var response: __HTTPResponse setget __noop_set


# Lifecycle methods

func _init(
	_request: HTTPRequest,
	_error: int = OK
) -> void:
	error = _error

	if error == OK:
		request = _request
		request.connect("request_completed", self, "__completed")
	else:
		yield(_request.get_tree(), "idle_frame")

		emit_signal("completed", response)


# Public methods

func cancel() -> void:
	if request == null:
		return

	request.cancel_request()


func is_valid() -> bool:
	return error != OK


# Private methods

func __completed(
	_result: int,
	_status_code: int,
	_headers: PoolStringArray,
	_body: PoolByteArray
) -> void:
	response = __HTTPResponse.new(
		_result,
		_status_code,
		__parse_headers(_headers),
		_body.get_string_from_utf8()
	)

	request = null

	emit_signal("completed", response)


func __noop_set(
	_value # Variant
) -> void:
	pass


func __parse_headers(
	_headers: Array
) -> Dictionary:
	var headers: Dictionary = {}

	for header in _headers:
		var parts: Array = header.split(":")

		var name: String = parts[0].strip_edges()
		var value: String = parts[1].strip_edges()

		headers[name] = value

	return headers
