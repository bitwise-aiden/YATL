tool
class_name HTTPRequester extends EditorPlugin

const URL_REGEX = "^(?<secure>(http|https)):\/\/(?<host>.*?)(?<request>\/.*)$"

var __regex: RegEx = null

func _init() -> void:
	self.__regex = RegEx.new()
	self.__regex.compile(URL_REGEX)


func request(method: int, url: String) -> RequestInstance:
	var url_parts = url.to_lower().split("?", true, 1)

	var result: RegExMatch = self.__regex.search(url_parts[0])
	if !result:
		return null

	var use_ssl: bool = result.get_string("secure") == "https"
	var host: String = result.get_string("host")
	var request: String = result.get_string("request")

	return RequestInstance.new(
		method,
		host,
		request,
		use_ssl
	)


func get(url: String) -> RequestInstance:
	return self.request(RequestInstance.Types.GET, url)


func delete(url: String) -> RequestInstance:
	return self.request(RequestInstance.Types.DELETE, url)


func put(url: String) -> RequestInstance:
	return self.request(RequestInstance.Types.PUT, url)


func post(url: String) -> RequestInstance:
	return self.request(RequestInstance.Types.POST, url)
