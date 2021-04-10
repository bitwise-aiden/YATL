var websocket: WebSocketClient = null


func _ready() -> void:
	self.websocket = WebSocketClient.new()
	if(self.websocket.connect_to_url("wss://irc-ws.chat.twitch.tv:443") != OK):
		print_debug("Could not connect to Twitch.")

	self.send("PASS ...")


func send(text : String, token : bool = false) -> void:
	websocket.get_peer(1).put_packet(text.to_utf8())
