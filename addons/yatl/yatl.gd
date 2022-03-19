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


# Public methods

func initialize_chat() -> Chat:
	chat = Chat.new(__pal)
	return chat

# TODO:
# line 1
# line 2
# line 3
# line 4
# line 5
# line 6
# velop add everything else lol
