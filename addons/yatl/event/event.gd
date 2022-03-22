extends Node


# Private imports

const __PAL: Resource = preload("../pal/pal.gd")
const __WebSocketConnection: Resource = __PAL.WebSocketConnection


# Public imports

const ChannelBanEvent: Resource = preload("./types/events.gd").ChannelBanEvent
const ChannelSubscribeEvent: Resource = preload("./types/events.gd").ChannelSubscribeEvent
const ChannelCheerEvent: Resource = preload("./types/events.gd").ChannelCheerEvent
const ChannelUpdateEvent: Resource = preload("./types/events.gd").ChannelUpdateEvent
const ChannelUnbanEvent: Resource = preload("./types/events.gd").ChannelUnbanEvent
const ChannelFollowEvent: Resource = preload("./types/events.gd").ChannelFollowEvent
const ChannelRaidEvent: Resource = preload("./types/events.gd").ChannelRaidEvent
const ChannelModeratorAddEvent: Resource = preload("./types/events.gd").ChannelModeratorAddEvent
const ChannelModeratorRemoveEvent: Resource = preload("./types/events.gd").ChannelModeratorRemoveEvent
const ChannelPollBeginEvent: Resource = preload("./types/events.gd").ChannelPollBeginEvent
const ChannelPollProgressEvent: Resource = preload("./types/events.gd").ChannelPollProgressEvent
const ChannelPollEndEvent: Resource = preload("./types/events.gd").ChannelPollEndEvent
const ChannelPointsCustomRewardAddEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardAddEvent
const ChannelPointsCustomRewardUpdateEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardUpdateEvent
const ChannelPointsCustomRewardRemoveEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRemoveEvent
const ChannelPointsCustomRewardRedemptionAddEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRedemptionAddEvent
const ChannelPointsCustomRewardRedemptionUpdateEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRedemptionUpdateEvent
const ChannelPredictionBeginEvent: Resource = preload("./types/events.gd").ChannelPredictionBeginEvent
const ChannelPredictionProgressEvent: Resource = preload("./types/events.gd").ChannelPredictionProgressEvent
const ChannelPredictionLockEvent: Resource = preload("./types/events.gd").ChannelPredictionLockEvent
const ChannelPredictionEndEvent: Resource = preload("./types/events.gd").ChannelPredictionEndEvent
const ChannelSubscriptionEndEvent: Resource = preload("./types/events.gd").ChannelSubscriptionEndEvent
const ChannelSubscriptionGiftEvent: Resource = preload("./types/events.gd").ChannelSubscriptionGiftEvent
const ChannelSubscriptionMessageEvent: Resource = preload("./types/events.gd").ChannelSubscriptionMessageEvent
const DropEntitlementGrantEvent: Resource = preload("./types/events.gd").DropEntitlementGrantEvent
const ExtensionBitsTransactionCreateEvent: Resource = preload("./types/events.gd").ExtensionBitsTransactionCreateEvent
const GoalsEvent: Resource = preload("./types/events.gd").GoalsEvent
const HypeTrainBeginEvent: Resource = preload("./types/events.gd").HypeTrainBeginEvent
const HypeTrainProgressEvent: Resource = preload("./types/events.gd").HypeTrainProgressEvent
const HypeTrainEndEvent: Resource = preload("./types/events.gd").HypeTrainEndEvent
const StreamOnlineEvent: Resource = preload("./types/events.gd").StreamOnlineEvent
const StreamOfflineEvent: Resource = preload("./types/events.gd").StreamOfflineEvent
const UserAuthorizationGrantEvent: Resource = preload("./types/events.gd").UserAuthorizationGrantEvent
const UserAuthorizationRevokeEvent: Resource = preload("./types/events.gd").UserAuthorizationRevokeEvent
const UserUpdateEvent: Resource = preload("./types/events.gd").UserUpdateEvent


# Private constants

const __EVENT_WSS_URL: String = "ws://127.0.0.1:25708"


# Private variables

var __pal: __PAL

var __broardcaster_user_id: String
var __client_id: String
var __access_token: String

var __connection: __WebSocketConnection

var __websocket_id: String
var __websocket_frequency_min: float

var __time_since_last_message: float = 0.0

var __connections: Dictionary = {
	# key: String - event
	# value: [[FuncRef, Array - binds], ...]
}


# Lifecycle methods

func _init(
	_pal: __PAL,
	_broadcaster_user_id: String,
	_client_id: String,
	_access_token: String
) -> void:
	__pal = _pal
	__broardcaster_user_id = _broadcaster_user_id
	__client_id = _client_id
	__access_token = _access_token


func _process(delta: float) -> void:
	if !__connection:
		return

	__time_since_last_message += delta


# Pubic methods

func connect_event(
	_event: String,
	_target: Object,
	_method: String,
	_binds: Array = []
) -> int:
	# TODO: Check if event is a valid event
	# return 1

	if !__connection && !yield(__establish_connection(__EVENT_WSS_URL), "completed"):
		return 2 # Some kind of error

	if __connections.has(_event):
		__connections[_event].append([
			funcref(_target, _method),
			_binds,
		])

		return OK

	# TODO: Convert this to use API method
	var response = __pal.request(
		'http://127.0.0.1:25708/helix/eventsub/subscriptions',
		{
			"client-id": __client_id,
			"authorization": "Bearer %s" % __access_token,
			"content-type": "application/json",
		},
		false,
		HTTPClient.METHOD_POST,
		to_json({
			"type": _event,
			"version": "1",
			"condition": {
				"broadcaster_user_id": __broardcaster_user_id,
			},
			"transport": {
				"method": "websocket",
				"id": __websocket_id,
			},
		})
	)

	response = yield(response, "completed")

	if response.error:
		return 3

	if response.response_code != 200:
		print(response.response_code)
		print(response.body)
		return 4

	__connections[_event] = []
	__connections[_event].append([
		funcref(_target, _method),
		_binds,
	])

	return OK


# Private methods

func __establish_connection(url: String) -> bool:
	__connection = yield(__pal.establish_connection(url), "completed")

	# TODO: Determine if reconnect should be tried
	if !__connection.connected:
		return false

	# Wait for welcome message
	var data_string: String = yield(__connection, "data_received")
	var data: Dictionary = parse_json(data_string)

	var type: String = data["metadata"]["message_type"]

	if type != "websocket_welcome":
		__connection.disconnect_socket()
		__connection = null

		return false

	var websocket_data: Dictionary = data["payload"]["websocket"]

	__websocket_id = websocket_data["id"]
	__websocket_frequency_min = float(websocket_data["minimum_message_frequency_seconds"])

	# Connect signal for future data
	__connection.connect("data_received", self, "__data_received")

	return true


func __data_received(data_string: String) -> void:
	var data: Dictionary =  parse_json(data_string)

	# TODO: Replay detection / prevention, LRU queue

	var type: String = data["metadata"]["message_type"]

	match type:
		"notification":
			__handle_notification(data["payload"])

	__time_since_last_message = 0.0


func __handle_notification(payload: Dictionary) -> void:
	var subscription_type: String = payload["subscription"]["type"]

	var raw_event_data: Dictionary = payload["event"]

	if __connections.has(subscription_type):
		var name: String = "%sEvent" % subscription_type \
			.replace(".", " ") \
			.capitalize() \
			.replace(" ", "") \
			.replace("ChannelChannel", "Channel")
		var event_resource: Resource = get(name)

		if !event_resource:
			return # TODO

		var event_data: Reference = event_resource.new(raw_event_data)

		for connection in __connections[subscription_type]:
			var function: FuncRef = connection[0]
			var binds: Array = connection[1]

			if !function.is_valid():
				continue # TODO: filter out invalid functions, close if none present

			function.call_funcv([event_data] + binds)
	else:
		pass # TODO
