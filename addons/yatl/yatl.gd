tool
extends Node

#Custom class preloads
const ChatMessage = preload("res://addons/yatl/chat/chat_message.gd")


#URL constants
const CHAT_WSS_URL: String = "wss://irc-ws.chat.twitch.tv:443"


#Signals
signal chat_connected(yatl_instance)
signal chat_disconnected(yatl_instance, clean) # clean: bool
signal chat_connection_failed(yatl_instance)
signal chat_joined(yatl_instance, channel) # channel: String
signal chat_message_received(yatl_instance, chat_message) # chat_message: ChatMessage


#Private variables
var __socket: WebSocketClient = WebSocketClient.new()
var __current_channel: String = ""


#Lifecycle methods
func _init() -> void:
	__socket.verify_ssl = true
	
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


func join_channel(channel: String) -> void:
	__socket_send("JOIN " + ("" if channel.begins_with("#") else "#") + channel.to_lower())
	__current_channel = channel


func leave_channel(channel: String = "") -> void:
	if __current_channel == "":
		return

	__socket_send("PART " + ("" if channel.begins_with("#") else "#") + channel.to_lower())
	__current_channel = ""


func send_message(message: String) -> void: #TODO: message queue
	if __current_channel == "":
		return

	__socket_send("PRIVMSG " + ("" if __current_channel.begins_with("#") else "#") + __current_channel + " :" + message)

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


func __socket_data_received() -> void: #TODO: handle data properly, ping/pong
	var data: PoolByteArray = __socket.get_peer(1).get_packet()
	var data_string: String = data.get_string_from_utf8()
	print(data_string)


func __socket_server_close_request(code: int, reason: String) -> void:
	print("server close request, code ", code, "; reason ", reason)


func __socket_send(message: String) -> void:
	__socket.get_peer(1).put_packet(message.to_utf8())
