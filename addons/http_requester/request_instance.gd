class_name RequestInstance

# Signals
signal request_complete(headers, body)
signal request_error(message)


# Enumerations
enum Types { GET = 0, DELETE, PUT, POST }


# Constant variables
const METHOD_MAP = [
	HTTPClient.METHOD_GET,
	HTTPClient.METHOD_DELETE,
	HTTPClient.METHOD_PUT,
	HTTPClient.METHOD_POST
]


# Private variables
var __headers: Dictionary = {}
var __host: String = ""
var __method: int = 0
var __params: Dictionary = {}
var __port: int = 443
var __request: String = ""
var __use_ssl: bool = true


# Lifecycle methods
func _init(method: int, host: String, request: String, use_ssl: bool) -> void:
	self.__method = self.METHOD_MAP[method]
	self.__host = host
	self.__request = request
	self.__use_ssl = use_ssl
	self.__port = 443 if use_ssl else 80

# Public methods
func headers(values: Dictionary) -> void:
	for key in values:
		self.__headers[key] = values[key]


func params(values: Dictionary) -> void:
	self.__headers["content-type"] = "application/x-www-form-urlencoded"

	for key in values:
		self.__params[key] = values[key]


func make(callback: FuncRef) -> void:

	var result = null
	var client: HTTPClient = HTTPClient.new()

	result = self.__connect_to_host(client)
	if result is GDScriptFunctionState:
		result = yield(result, "completed")

	if !result:
		self.emit_signal(
			"request_error",
			"Failed to connect to host: %s" % self.__host
		)
		return


	result = self.__request(client)
	if result is GDScriptFunctionState:
		result = yield(result, "completed")

	if !result:
		self.emit_signal(
			"request_error",
			"Failed to make request: %s" % self.__request
		)
		return

	result = self.__response_body(client)
	if result is GDScriptFunctionState:
		result = yield(result, "completed")

	var body: String = result
	var status: int = client.get_response_code()
	var headers: Dictionary = client.get_response_headers_as_dictionary()

	callback.call_func(status, headers, body)


# Private methods
func __connect_to_host(client: HTTPClient) -> bool:
	var error = client.connect_to_host(self.__host, self.__port, self.__use_ssl)
	if error:
		return false

	self.__poll_while(client, [HTTPClient.STATUS_CONNECTING, HTTPClient.STATUS_RESOLVING])
#
#	while client.get_status() == HTTPClient.STATUS_CONNECTING or client.get_status() == HTTPClient.STATUS_RESOLVING:
#		client.poll()
#		var delay = self.__delay(25)
#		if delay is GDScriptFunctionState:
#			yield(delay, "completed")

	return client.get_status() == HTTPClient.STATUS_CONNECTED


func __delay(msec: int) -> void:
	if OS.has_feature("web"):
		yield(Engine.get_main_loop(), "idle_frame")
	else:
		OS.delay_msec(msec)


func __poll_while(client, status_codes) -> void:
	while client.get_status() in status_codes:
		client.poll()
		var delay = self.__delay(25)
		if delay is GDScriptFunctionState:
			yield(delay, "completed")


func __request(client: HTTPClient) -> bool:
	var query_string: String = client.query_string_from_dict(self.__params)

	self.__headers["content-length"] = len(query_string)

	var headers: Array = []

	for key in self.__headers:
		headers.append("%s: %s" % [key, str(self.__headers[key])])

	var error = client.request(self.__method, self.__request, headers, query_string)
	if error:
		return false

	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll()
		var delay = self.__delay(25)
		if delay is GDScriptFunctionState:
			yield(delay, "completed")

	return client.get_status() in [HTTPClient.STATUS_BODY, HTTPClient.STATUS_CONNECTED]


func __response_body(client) -> String:
	if !client.has_response():
		return ""

	var response_body: PoolByteArray = PoolByteArray()

	while client.get_status() == HTTPClient.STATUS_BODY:
		client.poll()
		var chunk = client.read_response_body_chunk()
		if chunk.size() == 0:
			var delay = self.__delay(25)
			if delay is GDScriptFunctionState:
				yield(delay, "completed")
		else:
			response_body.append_array(chunk)

	return response_body.get_string_from_ascii()
