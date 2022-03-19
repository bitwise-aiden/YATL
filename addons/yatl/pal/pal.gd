extends Node

# Public imports

const HTTPResponse: Resource = preload("../shared/http_response.gd")
const WebSocketConnection: Resource = preload("../shared/web_socket_connection.gd")


# Private imports

const __RequestFactory: Resource = preload("./factories/request_factory.gd")
const __WebSocketFactory: Resource = preload('./factories/web_socket_factory.gd')


# Private variables

var __request_factory: __RequestFactory = __RequestFactory.new()
var __web_socket_factory: __WebSocketFactory = __WebSocketFactory.new()

# Lifecylce methods

func _ready() -> void:
	add_child(__request_factory)
	add_child(__web_socket_factory)


# Public methods

func establish_connection(
	_url: String
) -> WebSocketConnection:
	return __web_socket_factory.establish_connection(_url)


func request(
	_url: String,
	_headers: Dictionary = {},
	_use_ssl: bool = true,
	_method: int = 0,
	_data: String = ""
) -> HTTPResponse:
	return __request_factory.request(
		_url,
		_headers,
		_use_ssl,
		_method,
		_data
	)
