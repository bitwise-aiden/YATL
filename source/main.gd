extends Control

# Private variables

var __yatl: YATL = YATL.new()


# Lifecycle methods

func _ready() -> void:
	add_child(__yatl)

	var broadcaster_user_id: String = ""
	var client_id: String = ""
	var access_token: String = ""
#
	var event: YATL.Event = __yatl.initialize_event(
		broadcaster_user_id,
		client_id,
		access_token
	)

	event.connect_event(
		"channel.channel_points_custom_reward_redemption.add",
		self,
		"__point_redemption"
	)

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
