class_name Request

enum Types { GET = 0, DELETE, PUT, POST }

# Private variables
var __body: String = ""
var __endpoint: String = ""
var __headers: Dictionary = {
	# key: String, header name
	# value: Variant, header value
}
var __json_data = null # Variant
var __type: int = Types.GET

# Lifecyle methods
func _init(type: int, endpoint: String, headers: Dictionary, body: String) -> void:
	self.__body = body
	self.__endpoint = endpoint
	self.__headers = headers
	self.__type = type


# Public methods
func body() -> String:
	return self.__body


func endpoint() -> String:
	return self.__endpoint


func header(name: String = "", default = null): # Variant
	return self.__headers.get(name, default)


func headers() -> Dictionary:
	return self.__headers


func json(): # Variant
	if self.__json_data != null:
		return self.__json_data

	var content_type = self.header("content-type")
	if  content_type != "application/json":
		print(
			"[WRN] Attempting to call get_json on a request with content-type: %s" % [content_type]
		)
		return null

	var result = JSON.parse(self.__body)
	if result.error:
		print(
			"[ERR] Error parsing request json: %s" % [result.error_string]
		)

	self.__json_data = result.result

	return self.__json_data


func type() -> int:
	return self.__type
