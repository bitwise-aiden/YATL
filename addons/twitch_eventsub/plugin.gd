tool
extends EditorPlugin


# Private variables
var __server: HTTPServer = null
var __secret: String = "lumikkode_is_the_best"
var __settings: Dictionary = {}


# Lifecycle methods
func _enter_tree():
	self.__settings = self.__load_settings()

	var twitch_event_sub: TwitchEventSub = TwitchEventSub.new(
		self.__settings['client_id'],
		self.__settings['client_secret']
	)
	twitch_event_sub.listen()


func _process(delta: float) -> void:
	if self.__server == null:
		self.__start_server(3001)

	self.__server.take_connection()


# Private methods
func __start_server(port: int = 3000) -> void:
	self.__server = HTTPServer.new()

	self.__server.endpoint(Request.Types.POST, "/callback", funcref(self, "__callback"))

	self.__server.listen(port)


func __callback(request: Request, response: Response) -> void:
	# This endpoint will return 200 regardless of request verification, so
	# explicitly set value ahead of time.
	response.status(200)

	# verify headers
	if !self.__verify_request(request):
		response.status(403)
		return

	if request.header("twitch-eventsub-message-type") == "webhook_callback_verification":
		response.data(request.json()["challenge"])
	else:
		response.data("acknowledged")

	var request_data: Dictionary = request.json()
	match request.header("twitch-eventsub-message-type"):
		"webhook_callback_verification":
			response.data(request_data["challenge"])
		"notification":
			self.__handle_event(request_data)

func __load_settings() -> Dictionary:
	var file: File = File.new()

	if file.file_exists("user://plugin.json"):
		file.open("user://plugin.json", File.READ)
		var content: String = file.get_as_text()
		file.close()

		return JSON.parse(content).result

	return {}

func __verify_request(request: Request) -> bool:
	var message_id: String = request.header("twitch-eventsub-message-id")
	var timestamp: String = request.header("twitch-eventsub-message-timestamp")
	var signature: String = request.header("twitch-eventsub-message-signature")

	var hmac_message: String = message_id + timestamp + request.body()

	var hmac: Hmac = Hmac.new(Hmac.Types.SHA256, self.__secret)
	hmac.update(hmac_message)

	var expected_signature_header: String = "sha256=%s" % [hmac.digest()]

	return signature == expected_signature_header


func __handle_event(request_data: Dictionary) -> void:
	match request_data["subscription"]:
		{"type": "channel.channel_points_custom_reward_redemption.add", ..}:
			var event: Dictionary = request_data["event"]

			print("%s has redeemed %s" % [
				event["user_name"], event["reward"]["title"]
			])
		{"type": var type, ..}:
			print("Unknown type: %s" % [type])
