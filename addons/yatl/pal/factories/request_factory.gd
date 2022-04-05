extends Node


# Public imports

const HTTPRequestState: Resource = preload("../types/http_request_state.gd")
const HTTPResponse: Resource = preload("../types/http_response.gd")


# Public methods

func request(
	_url: String,
	_options: Dictionary = {}
) -> HTTPRequestState:
	var request: HTTPRequest = HTTPRequest.new()
	request.use_threads = true # TODO: Make this a setting
	add_child(request)

	var error: int = request.request(
		"%s%s" % [_url, __formatted_query(_options)],
		__formatted_headers(_options),
		_options.get("use_ssl", true),
		_options.get("method", HTTPClient.METHOD_GET),
		__formatted_data(_options)
	)

	var state: HTTPRequestState = HTTPRequestState.new(request, error)
	state.connect("completed", self, "__completed", [request])

	return state


# Private methods

func __completed(
	_response: HTTPResponse,
	_request: HTTPRequest
) -> void:
	_request.queue_free()

func __formatted_data(
	_options: Dictionary
) -> String:
	var data = _options.get("data")
	if !data:
		return ""

	# Assumes json serializable
	return to_json(data)


func __formatted_headers(
	_options: Dictionary
) -> PoolStringArray:
	var formatted_headers: PoolStringArray = PoolStringArray()

	var headers = _options.get("headers")

	if headers != TYPE_DICTIONARY || headers.empty():
		return formatted_headers

	for header in headers:
		formatted_headers.append(
			"%s: %s" % [header, headers[header]]
		)

	return formatted_headers


func __formatted_query(
	_options: Dictionary
) -> String:
	var queries = _options.get("query")

	if queries != TYPE_DICTIONARY || queries.empty():
		return ""

	var query_parts: PoolStringArray = PoolStringArray()

	for query in queries:
		query_parts.append(
			"%s=%s" % [query, queries[query]]
		)

	return "?%s" % query_parts \
		.join("&") \
		.http_escape()
