class_name TwitchEventSub

enum Types { CHANNEL_POINT_REDEMPTION }

const AUTHENTICATION_URL = "id.twitch.tv"
const AUTHENTICATION_REQUEST = "/oauth2/token?client_id=%s&client_secret=%s&grant_type=%s&scope=%s"

var __client_id: String = ""
var __client_secret: String = ""
var __scopes: Array = [
	"channel:read:redemptions"
]


# Lifecycle methods
func _init(client_id: String, client_secret: String):
	self.__client_id = client_id
	self.__client_secret = client_secret


# Public methods
func listen(port: int = 3000) -> void:
	var requester = HTTPRequester.new()
	var request: RequestInstance = requester.post(
		"https://id.twitch.tv/oauth2/token"
	)
	request.params({
		"client_id": self.__client_id,
		"client_secret": self.__client_secret,
		"grant_type": "client_credentials",
		"scopes": PoolStringArray(self.__scopes).join("%20")
	})

	print("This is before the request was made")
	request.make(funcref(self, "__handle_request"))

	print("pre yield")
	yield(InstantYield.new(), "completed")
	print("This is after the request was made")


#	self.__authenticate()
	# Setup web server
	# create auth token
	# Create event


func __handle_request(status, headers, body):
	print("This is the request completing")
	print(status)
	print(headers)
	print(body)


func subscribe(type: int, callback: FuncRef) -> void:
	# setup the callback function
	# register type to be subscribed to
	# set scopes
	pass


# Private methods
func __authenticate() -> void:
	var err = 0
	var request = self.AUTHENTICATION_REQUEST % [
		self.__client_id,
		self.__client_secret,
		"client_credentials",
		PoolStringArray(self.__scopes).join("%20")
	]

	var client: HTTPClient = HTTPClient.new()
	err = client.connect_to_host(self.AUTHENTICATION_URL, 443, true)
	assert(err == OK, "1")

	while client.get_status() == HTTPClient.STATUS_CONNECTING or client.get_status() == HTTPClient.STATUS_RESOLVING:
		client.poll()
		if not OS.has_feature("web"):
			OS.delay_msec(25)
		else:
			yield(Engine.get_main_loop(), "idle_frame")

	assert(client.get_status() == HTTPClient.STATUS_CONNECTED, "2")

	err = client.request(HTTPClient.METHOD_POST, request, [])
	assert(err == OK, "3")

	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll()
		if OS.has_feature("web"):
			yield(Engine.get_main_loop(), "idle_frame")
		else:
			OS.delay_msec(25)

	assert(client.get_status() == HTTPClient.STATUS_BODY or client.get_status() == HTTPClient.STATUS_CONNECTED) # Make sure request finished well.

	if client.has_response():
		var rb = PoolByteArray()

		while client.get_status() == HTTPClient.STATUS_BODY:
			client.poll()
			var chunk = client.read_response_body_chunk()
			if chunk.size() == 0:
				if not OS.has_feature("web"):
					OS.delay_usec(25)
				else:
					yield(Engine.get_main_loop(), "idle_frame")
			else:
				rb = rb + chunk

		print("bytes got: ", rb.size())
		var text = rb.get_string_from_ascii()
		print("Text: ", text)



func __request_completed(result, response_code, headers, body) -> void:
	print(result, response_code, headers, body)
