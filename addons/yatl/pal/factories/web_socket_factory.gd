extends Node


# Public imports


const WebSocketConnection: Resource = preload("../../shared/web_socket_connection.gd")


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
) -> WebSocketConnection:
	var client: WebSocketClient = WebSocketClient.new()
	client.connect("connection_closed", self, "_closed", [client])
	client.connect("connection_error", self, "_closed", [false, client])

	var connection: WebSocketConnection = WebSocketConnection.new(client)

	var error: int = client.connect_to_url(_url)

	if error:
		push_error("An error occured while connecting websocket.")

		connection.__connection_error(error, get_tree())
	else:
		__clients.append(client)

	return connection


# Private methods

func _closed(
	_was_clean_close: bool,
	_client: WebSocketClient
) -> void:
	var index: int = __clients.find(_client)
	if index != -1:
		__clients.remove(index)
