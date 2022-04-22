# Public variables

var body: String setget __noop_set
var headers: Dictionary setget __noop_set
var json setget __noop_set # Variant
var result: int setget __noop_set
var status_code: int setget __noop_set


# Lifecycle methods

func _init(
	_result: int,
	_status_code: int,
	_headers: Dictionary,
	_body: String
) -> void:
	headers = _headers
	body = _body
	result = _result
	status_code = _status_code

	if headers.get("content-type", "") == "application/json":
		json = parse_json(body)


# Public methods

func is_valid() -> bool:
	return result != HTTPRequest.RESULT_SUCCESS


# Private methods

func __noop_set(
	value # Variant
) -> void:
	pass
