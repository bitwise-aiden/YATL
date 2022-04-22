# Private imports

const __WebSocketConnection = preload("./web_socket_connection.gd")

# Public signals

signal completed(connection)


# Private signals

signal __completed() # Friend: WebSocketFactory


# Public variables

var client: WebSocketClient setget __noop_set
var connection: __WebSocketConnection setget __noop_set
var error: int setget __noop_set


# Lifecycle methods

func _init(
	_client: WebSocketClient,
	_error: int = OK
) -> void:
	error = _error

	if error == OK:
		client = _client

		client.connect("connection_error", self, "__completed", [false])
		client.connect("connection_established", self, "__completed", [true])
	else:
		yield(self, "__completed")

		connection = __WebSocketConnection.new(
			null,
			false
		)

		emit_signal("completed", connection)


# Public methods

func is_valid() -> bool:
	return error != OK


# Private methods

func __completed(
	_success: bool
) -> void:
	connection = __WebSocketConnection.new(
		client,
		_success
	)

	emit_signal("completed", connection)


func __noop_set(
	_value # Variant
) -> void:
	pass
