extends Node

# Public imports

const DataType: Resource = preload("./types/data_type.gd")
const HTTPRequestState: Resource = preload("./types/http_request_state.gd")
const HTTPResponse: Resource = preload("./types/http_response.gd")
const WebSocketConnection: Resource = preload("../shared/web_socket_connection.gd")


# Private imports

const __DataHelper: Resource = preload("./helpers/data_helper.gd")
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

func as_data_type(
	_data_type: Resource,
	_data # Variant
) -> DataType:
	return __DataHelper.as_data_type(_data_type, _data)


func establish_connection(
	_url: String
) -> WebSocketConnection:
	return __web_socket_factory.establish_connection(_url)


func request(
	_url: String,
	_options: Dictionary = {}
) -> HTTPRequestState:
	return __request_factory.request(
		_url,
		_options
	)
