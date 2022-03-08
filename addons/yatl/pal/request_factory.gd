extends Node


# Public imports

const HTTPResponse: Resource = preload("../shared/http_response.gd")


# Public methods

func request(
	_url: String,
	_headers: Dictionary = {},
	_use_ssl: bool = true,
	_method: int = 0,
	_data: String = ""
) -> HTTPResponse:
	var request: HTTPRequest = HTTPRequest.new()
	request.use_threads = true # TODO: Make this a setting

	add_child(request)

	var response: HTTPResponse = HTTPResponse.new(request)

	var formatted_headers: PoolStringArray = PoolStringArray()

	for header in _headers:
		formatted_headers.append(
			"%s: %s" % [header, _headers[header]]
		)

	var error: int = request.request(
		_url,
		formatted_headers,
		_use_ssl,
		_method,
		_data
	)

	if error != OK:
		push_error("An error occured while making the HTTP request.")

		response.__request_error(error)

	return response

