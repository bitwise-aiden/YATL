# Private imports

const __HTTPResponse = preload("./http_response.gd")


# Public signals

signal completed(result, response)


# Public variables

var error: int setget __noop_set
var request: HTTPRequest setget __noop_set
var response: __HTTPResponse setget __noop_set


# Lifecycle methods

func _init(
	_request: HTTPRequest
) -> void:
	request = _request
	request.connect("request_completed", self, "__completed")


# Private methods

func __completed(
	_result: int,
	_status_code: int,
	_headers: PoolStringArray,
	_body: PoolByteArray
) -> void:
	if _result == HTTPRequest.RESULT_SUCCESS:
		response = __HTTPResponse.new(
			_status_code,
			__parse_headers(_headers),
			_body.get_string_from_utf8()
		)
	else:
		pass # TODO: Determine what to do here if the result isn't OK

	emit_signal("completed", _result, response)


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

		var name: String = parts[0].trim_prefix(" ").trim_suffix(" ")
		var value: String = parts[1].trim_prefix(" ").trim_suffix(" ")

		headers[name] = value

	return headers
