extends Control

# Private variables

var __yatl: YATL = YATL.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__yatl)

	var broadcaster_user_id: String = OS.get_environment("TWITCH_BROADCASTER_USER_ID")
	var client_id: String = OS.get_environment("TWITCH_CLIENT_ID")
	var access_token: String = OS.get_environment("TWITCH_ACCESS_TOKEN")
#
	var event: YATL.Event = __yatl.initialize_event(
		broadcaster_user_id,
		client_id,
		access_token
	)

	yield(get_tree().create_timer(1.0), "timeout")

	var result = event.connect_event(
		"channel.channel_points_custom_reward_redemption.add",
		self,
		"__point_redemption"
	)

	yield(result, "completed")

	event.connect_event(
		"channel.follow",
		self,
		"__follow"
	)


# Private methods

func __follow(event: YATL.Event.ChannelFollowEvent) -> void:
	print("%s followed!" % event.user_name)


func __point_redemption(event: YATL.Event.ChannelPointsCustomRewardRedemptionAddEvent) -> void:
	print("%s redeemed: %s" % [event.user_name, event.reward.title])
