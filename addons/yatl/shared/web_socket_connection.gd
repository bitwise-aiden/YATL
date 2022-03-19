# Public signals

signal completed(connection)
signal data_received(data)
signal disconnected()


# Public variables


var client: WebSocketClient

var connected: bool setget __noop_set
var error: int setget __noop_set  # Error


# Lifecycle methods

func _init(
	_client: WebSocketClient
) -> void:
	client = _client

	client.connect("connection_closed", self, "__closed")
	client.connect("connection_error", self, "__closed")
	client.connect("data_received", self, "__data_received")
	client.connect("connection_connected", self, "__connected")


# Private methods

func __closed() -> void:
	if connected:
		connected = false
		emit_signal("disconnected")
	else:
		emit_signal("completed", self)


func __connected() -> void:
	connected = true

	emit_signal("completed", self)


func __connection_error(
	_error: int,
	tree: SceneTree
) -> void: # Friend: RequestFactory
	error = _error

	client = null

	yield(tree, "idle_frame")

	emit_signal("completed", self)


func __data_received() -> void:
	emit_signal("data_received", client.get_peer(1).get_packet().get_string_from_utf8())


func __noop_set(
	_value # Variant
) -> void:
	pass
