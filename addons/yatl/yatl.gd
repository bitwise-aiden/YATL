tool
extends Node

#Custom class preloads
const ChatMessage = preload("res://addons/yatl/chat/chat_message.gd")


#URL constants
const CHAT_WSS_URL: String = "wss://irc-ws.chat.twitch.tv:443"


#Signals
signal chat_connected(yatl_instance)
signal chat_login(yatl_instance, success) # success: bool
signal chat_disconnected(yatl_instance, clean) # clean: bool
signal chat_connection_failed(yatl_instance)
signal chat_joined(yatl_instance, channel) # channel: String
signal chat_message_received(yatl_instance, chat_message) # chat_message: ChatMessage
signal chat_whisper_received(yatl_instance, chat_message) # chat_message: ChatMessage
signal chat_raw_data_received(yatl_instance, raw_data) # raw_data: String
signal chat_ping_received(yatl_instance)


#Private variables
var __socket: WebSocketClient = WebSocketClient.new()
var __channel_list: Array = []

var __username_pattern: String = ":([\\w]+)!"
var __username_regex = RegEx.new()


#Lifecycle methods
func _init() -> void:
	__socket.verify_ssl = true
	
	__username_regex.compile(__username_pattern)
	
	__socket.connect("connection_closed", self, "__socket_connection_closed")
	__socket.connect("connection_established", self, "__socket_connection_established")
	__socket.connect("connection_error", self, "__socket_connection_error")
	__socket.connect("data_received", self, "__socket_data_received")
	__socket.connect("server_close_request", self, "__socket_server_close_request")


func _process(_delta: float) -> void:
	if __socket.get_connection_status() != __socket.CONNECTION_DISCONNECTED:
		__socket.poll()


#Public methods - chat
func chat_connect() -> void:
	print("chat connect called")
	if __socket.connect_to_url(CHAT_WSS_URL) != OK:
		emit_signal("chat_connection_failed", self)


func chat_disconnect() -> void:
	if !(__socket.get_peer(1).is_connected_to_host()):
		return
	
	__socket.disconnect_from_host()


func chat_auth(nick: String, token: String) -> void:
	__socket.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	__socket_send("PASS " + ("" if token.begins_with("oauth:") else "oauth:") + token)
	__socket_send("NICK " + nick.to_lower())
	__socket_send("CAP REQ :twitch.tv/commands twitch.tv/tags twitch.tv/membership")


func join_channel(channel: String) -> void:
	__socket_send("JOIN " + ("" if channel.begins_with("#") else "#") + channel.to_lower())
#	__current_channel = channel


func leave_channel(channel: String = "") -> void:
#	if __current_channel == "":
#		return

	__socket_send("PART " + ("" if channel.begins_with("#") else "#") + channel.to_lower())
#	__current_channel = ""


func send_message(message: String) -> void: #TODO: message queue
#	if __current_channel == "":
#		return
	pass
#	__socket_send("PRIVMSG " + ("" if __current_channel.begins_with("#") else "#") + __current_channel + " :" + message)


#Private methods
func __socket_connection_closed(clean: bool) -> void:
	print("disconnected, clean ", clean)
	emit_signal("chat_disconnected", self, clean)


func __socket_connection_established(protocol: String) -> void:
	print("connection established with protocol ", protocol)
	emit_signal("chat_connected", self)


func __socket_connection_error() -> void:
	print("connection error")
	emit_signal("chat_connection_failed", self)


func __socket_data_received() -> void:
	var data: PoolByteArray = __socket.get_peer(1).get_packet()
	var data_string: String = data.get_string_from_utf8().strip_edges(false)
	emit_signal("chat_raw_data_received", self, data_string)
	var messages: PoolStringArray = data_string.split("\r\n")
#	print("> ", data_string)
	var tags: Dictionary = {}
	for message in messages:
		if message.begins_with("@"):
			var new_message: PoolStringArray = message.split(" ", false, 1)
			message = new_message[1]
			for t in new_message[0].split(";"):
				var kv: PoolStringArray = t.split("=")
				tags[kv[0]] = kv[1]
		
		__chat_message(message, tags)


func __socket_server_close_request(code: int, reason: String) -> void:
	print("server close request, code ", code, "; reason ", reason)


func __socket_send(message: String) -> void:
	__socket.get_peer(1).put_packet(message.to_utf8())


func __chat_message(message: String, tags: Dictionary) -> void:
	print("> ", message)
	if(message == ":tmi.twitch.tv NOTICE * :Login authentication failed"):
		emit_signal("chat_login", self, false)
		return
	
	if(message == "PING :tmi.twitch.tv"):
		emit_signal("chat_ping_received", self)
		__socket_send("PONG :tmi.twitch.tv")
		return
	
	var split: PoolStringArray = message.split(" ", true, 3)
	match split[1]:
		"001":
			emit_signal("chat_login", self, true)
		"PRIVMSG":
			var chat_message: ChatMessage = ChatMessage.new(__username_regex.search(split[0]).get_string(1), split[3].right(1), split[2], tags)
			emit_signal("chat_message_received", self, chat_message)
