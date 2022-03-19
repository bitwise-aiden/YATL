# Private imports

const __PAL: Resource = preload("../pal/pal.gd")
const __WebSocketConnection: Resource = __PAL.WebSocketConnection


# Public imports

const ChatMessage = preload("./chat_message.gd")


#Signals

signal connected()
signal login(success) # success: bool
signal disconnected()
signal connection_failed()
signal channel_joined(channel) # channel: String
signal channel_left(channel) # channel: String
signal message_received(chat_message) # chat_message: ChatMessage
signal whisper_received(chat_message) # chat_message: ChatMessage


# URL constants

const CHAT_WSS_URL: String = "wss://irc-ws.chat.twitch.tv:443"


# Public variables

var reconnect: bool = false # Whether or not to try and reconnect automatically
var message_queue_timeout: float = 0.33 # how long to wait after sending each message


# Private variables

var __pal: __PAL

var __client: WebSocketClient
var __socket_connection: __WebSocketConnection

var __current_channel: String
var __username_pattern: String = ":([\\w]+)!"
var __username_regex = RegEx.new()

var __message_queue: Array = []
var __time_elapsed: float = 0.0


# Lifecycle methods

func _init(pal: __PAL) -> void:
	__pal = pal
	
	__username_regex.compile(__username_pattern)


func _process(delta: float) -> void:
	if !__socket_connection:
		return
	
	if !__socket_connection.connected:
		return
	
	if !__message_queue.empty() && __time_elapsed >= message_queue_timeout:
		__client_put_message(__message_queue.pop_front())
		__time_elapsed = 0
	else:
		__time_elapsed += delta


# Public methods

func chat_connect() -> void:
	if __socket_connection && __socket_connection.connected:
		return

	__socket_connection = __pal.establish_connection(CHAT_WSS_URL)
	yield(__socket_connection, "completed")
	if __socket_connection.connected:
		emit_signal("connected")
		__socket_connection.connect("disconnected", self, "__on_socket_connection_disconnected")
		__client = __socket_connection.client
	else:
		emit_signal("connection_failed")


func chat_disconnect() -> void:
	if !__socket_connection || !__socket_connection.connected:
		return
		
	__socket_connection.client.disconnect_from_host() # TODO: velop expose disconnect_from_host() to WebsocketConnection
	yield(__socket_connection, "disconnected")
	__client = null
	__socket_connection = null


func authenticate(nick: String, token: String) -> void:
	if !__socket_connection || !__socket_connection.connected:
		return
	
	__client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	__client_put_message("PASS " + ("" if token.begins_with("oauth:") else "oauth:") + token)
	__client_put_message("NICK " + nick.to_lower())
	__client_put_message("CAP REQ :twitch.tv/commands twitch.tv/tags twitch.tv/membership")


func join_channel(channel: String) -> void:
	__client_put_message("JOIN " + ("" if channel.begins_with("#") else "#") + channel.to_lower().strip_edges())


func leave_current_channel() -> void:
	if __current_channel.empty():
		return
	
	__client_put_message("PART " + __current_channel)


func send_message(message: String) -> void:
	__message_queue.append("PRIVMSG #" + __current_channel + " :" + message)


# Private methods

func __on_socket_connection_disconnected():
	emit_signal("disconnected")


func __on_socket_connection_data_received(data: String) -> void:
	data = data.strip_edges(false)
	var messages: PoolStringArray = data.split("\r\n")
	var tags: Dictionary = {}
	for message in messages:
		if message.begins_with("@"):
			var new_message: PoolStringArray = message.split(" ", false, 1)
			message = new_message[1]
			for tag in new_message[0].split(";"):
				var kv: PoolStringArray = tag.split("=")
				tags[kv[0]] = kv[1]

		__handle_chat_message(message, tags)


func __handle_chat_message(message: String, tags: Dictionary) -> void:
	if message == ":tmi.twitch.tv NOTICE * :Login authentication failed":
		emit_signal("login", false)
		return
	
	if message == "PING :tmi.twitch.tv":
		__client_put_message("PONG :tmi.twitch.tv")
		return
	
	var split: PoolStringArray = message.split(" ", true, 3)
	match split[1]:
		"001":
			emit_signal("login", true)
		"PRIVMSG":
			var chat_message: ChatMessage = ChatMessage.new(__username_regex.search(split[0]).get_string(1), split[3].right(1), split[2], tags)
			emit_signal("message_received", chat_message)
		"JOIN":
			__current_channel = split[2]
			emit_signal("channel_joined", __current_channel)
		"PART":
			emit_signal("channel_left", __current_channel)
			__current_channel = split[2]
		#TODO: WHISPER, NOTICE, RECONNECT


func __client_put_message(message: String) -> void:
	if !__client:
		return
	
	__client.get_peer(1).put_packet(message.to_utf8())
