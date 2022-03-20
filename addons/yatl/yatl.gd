extends Node
class_name YATL, "./yatl_icon.png"


# Private imports

const __PAL: Resource = preload("./pal/pal.gd")


# Public imports

const API: Resource = preload("./api/api.gd")
const Chat: Resource = preload("./chat/chat.gd")
const Event: Resource = preload("./event/event.gd")


# Public variables

var chat: Chat
var api: API
var event: Event


# Private variables

var __pal: __PAL = __PAL.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__pal)


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


func initialize_event() -> Event:
	event = Event.new(__pal)

	return event
