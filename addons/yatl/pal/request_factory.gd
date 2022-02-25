extends Node


# Private imports

const __HTTPResponse: Resource = preload("../shared/http_response.gd")


# Public methods

func request(
	url: String,
	headers: Dictionary = {},
	use_ssl: bool = true,
	method: int = 0,
	data: String = ""
) -> __HTTPResponse:
	var request: HTTPRequest = HTTPRequest.new()
	request.use_threads = true # TODO: Make this a setting

	add_child(request)

	var response: __HTTPResponse = __HTTPResponse.new(request)

	var formatted_headers: PoolStringArray = PoolStringArray()

	for header in headers:
		formatted_headers.append(
			"%s: %s" % [header, headers[header]]
		)

	var error: int = request.request(
		url,
		formatted_headers,
		use_ssl,
		method,
		data
	)

	if error != OK:
		push_error("An error occured while making the HTTP request.")

		response.__request_error(error)

	return response

