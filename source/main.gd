extends Control

#const RequestFactory = preload("res://addons/yatl/pal/factories/request_factory.gd")
#const WebSocketFactory = preload("res://addons/yatl/pal/factories/web_socket_factory.gd")

var yatl: YATL = YATL.new()


func _ready() -> void:
#	var request_factory: RequestFactory = RequestFactory.new()
#	add_child(request_factory)
#
#	var a = yield(request_factory.request("https://httpstat.us/200"), "completed")
#	print(a.response_code)
#
#	var b = yield(request_factory.request("https://httpstat.us/400"), "completed")
#	print(b.response_code)
#
#	var web_socket_factory: WebSocketFactory = WebSocketFactory.new()
#	add_child(web_socket_factory)
#
#	var c = yield(web_socket_factory.establish_connection("ws://test.we:8000"), "completed")
#	print(c.connected)
	add_child(yatl)

	var broadcaster_user_id: String = ""
	var client_id: String = ""
	var access_token: String = ""

	var event: YATL.Event = yatl.initialize_event(broadcaster_user_id, client_id, access_token)

	event.connect_event(
		"channel.channel_points_custom_reward_redemption.add",
		self,
		"__point_redemption"
	)

	event.connect_event(
		"channel_follow",
		self,
		"__follow"
	)


func __follow(event: YATL.Event.ChannelFollowEvent) -> void:
	print("%s followed!" % event.user_name)


func __point_redemption(event: YATL.Event.ChannelPointsCustomRewardRedemptionAddEvent) -> void:
	print("%s redeemed: %s" % [event.user_name, event.reward.title])
