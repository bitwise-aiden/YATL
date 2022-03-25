extends Node
class_name YATL, "./yatl_icon.png"


# Private imports

const __PAL: Resource = preload("./pal/pal.gd")
const __EventProxy: Resource = preload("res://addons/yatl/event/proxy/proxy.gd")


# Public imports

const API: Resource = preload("./api/api.gd")
const Chat: Resource = preload("./chat/chat.gd")
const Event: Resource = preload("./event/event.gd")


# Public variables

var chat: Chat
var api: API
var event: Event


# Private variables

var __pal: __PAL
var __proxy: __EventProxy


# Lifecycle methods

func _ready() -> void:
	__pal = __PAL.new()
	add_child(__pal)

	__proxy = __EventProxy.new(__pal)
	add_child(__proxy)


func _process(delta: float) -> void:
	if chat:
		chat._process(delta)


# Public methods

func initialize_api() -> API:
	api = API.new(__pal)

	return api


func initialize_chat() -> Chat:
	chat = Chat.new(__pal)

	return chat


func initialize_event(
	_broadcaster_user_id: String,
	_client_id: String,
	_access_token: String
) -> Event:
	event = Event.new(__pal, _broadcaster_user_id, _client_id, _access_token)

	add_child(event)

	return event
