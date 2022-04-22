# Public signals

signal data_received(data)
signal disconnected()

# Public variables

var client: WebSocketClient setget __noop_set
var connected: bool setget __noop_set


# Lifecycle methods

func _init(
	_client: WebSocketClient,
	_connected: bool
) -> void:
	connected = _connected

	if connected:
		client = _client

		client.connect("connection_closed", self, "__connection_closed")
		client.connect("data_received", self, "__data_received")


# Public methods

func disconnect_from_host(
	_code: int = 1000,
	_reason: String = ""
) -> void:
	if client == null:
		return

	client.disconnect_from_host(_code, _reason)


func is_valid() -> bool:
	return connected


# Private methods

func __connection_closed(
	_was_clean_close: bool
) -> void:
	connected = false
	client = null

	emit_signal("disconnected")


func __data_received() -> void:
	var peer: WebSocketPeer = client.get_peer(1)
	var packet: PoolByteArray = peer.get_packet()

	emit_signal("data_received", packet.get_string_from_utf8())


func __noop_set(
	_value # Variant
) -> void:
	pass
