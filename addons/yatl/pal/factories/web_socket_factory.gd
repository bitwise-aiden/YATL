extends Node


# Public imports


const WebSocketConnectionState: Resource = preload("../types/web_socket_connection_state.gd")


# Private variables

var __clients: Array = []


# Lifecycle methods

func _process(
	_delta: float
) -> void:
	for client in __clients:
		client.poll()


# Public methods

func establish_connection(
	_url: String
) -> WebSocketConnectionState:
	var client: WebSocketClient = WebSocketClient.new()

	client.connect("connection_closed", self, "__closed", [client])
	client.connect("connection_error", self, "__closed", [false, client])

	var error: int = client.connect_to_url(_url)

	var state: WebSocketConnectionState = WebSocketConnectionState.new(
		client,
		error
	)

	if error == OK:
		__clients.append(client)
	else:
		__trigger_completed(state)


	return state


# Private methods

func __closed(
	_was_clean_close: bool,
	_client: WebSocketClient
) -> void:
	var index: int = __clients.find(_client)

	if index != -1:
		__clients.remove(index)


func __trigger_completed(
	state: WebSocketConnectionState
) -> void:
	yield(self.get_tree(), "idle_frame")

	state.emit_signal("__completed")
