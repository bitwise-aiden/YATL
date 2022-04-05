# Public variables

var status_code: int setget __noop_set
var headers: Dictionary setget __noop_set
var body: String setget __noop_set
var json setget __noop_set # Variant


# Lifecycle methods

func _init(
	_status_code: int,
	_headers: Dictionary,
	_body: String
) -> void:
	status_code = _status_code
	headers = _headers
	body = _body

	if headers.get("content-type", "") == "application/json":
		json = parse_json(body)


# Private methods

func __noop_set(
	value # Variant
) -> void:
	pass
