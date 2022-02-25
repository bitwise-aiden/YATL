extends Resource

# Public signals

signal completed(response)


# Private variables

var request: HTTPRequest = null

var error: int setget __noop_set # Error
var result: int setget __noop_set # HTTPRequest Result
var response_code: int setget __noop_set
var headers: Dictionary setget __noop_set
var body: PoolByteArray setget __noop_set


# Lifecycle methods

func _init(
	request: HTTPRequest
) -> void:
	self.request = request

	request.connect("request_completed", self, "__request_completed")


# Private methods

func __noop_set(_value) -> void:
	pass


func __request_completed(
	p_result: int,
	p_response_code: int,
	p_headers: PoolStringArray,
	p_body: PoolByteArray
) -> void:
	result = p_result
	response_code = p_response_code
	headers = {}

	for header in p_headers:
		var parts: Array = header.split(":")

		var name: String = parts[0].trim_prefix(" ").trim_suffix(" ")
		var value: String = parts[1].trim_prefix(" ").trim_suffix(" ")

		headers[name] = value

	body = p_body

	emit_signal("completed", self)


func __request_error(
	p_error: int
) -> void:
	error = error

	yield(request.get_tree(), "idle_frame")

	emit_signal("completed", self)
