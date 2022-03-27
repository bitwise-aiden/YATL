# Private imports

const __Base: Resource = preload("./shared.gd").__Base


# Public classes

class Event extends __Base:
	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelBanEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var moderator_user_id: String
	var moderator_user_login: String
	var moderator_user_name: String
	var reason: String
	var ends_at: String
	var is_permanent: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelSubscribeEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var tier: String
	var is_gift: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelCheerEvent extends Event:
	# Public variables

	var is_anonymous: bool
	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var message: String
	var bits: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelUpdateEvent extends Event:
	# Public variables

	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var language: String
	var category_id: String
	var category_name: String
	var is_mature: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelUnbanEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var moderator_user_id: String
	var moderator_user_login: String
	var moderator_user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelFollowEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var followed_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelRaidEvent extends Event:
	# Public variables

	var from_broadcaster_user_id: String
	var from_broadcaster_user_login: String
	var from_broadcaster_user_name: String
	var to_broadcaster_user_id: String
	var to_broadcaster_user_login: String
	var to_broadcaster_user_name: String
	var viewers: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelModeratorAddEvent extends Event:
	# Public variables

	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var user_id: String
	var user_login: String
	var user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelModeratorRemoveEvent extends Event:
	# Public variables

	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var user_id: String
	var user_login: String
	var user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelPollBeginEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const BitsVoting: Resource = preload("./shared.gd").BitsVoting
	const ChannelPointsVoting: Resource = preload("./shared.gd").ChannelPointsVoting
	const Choice: Resource = preload("./shared.gd").Choice


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var choices: Array
	var bits_voting: BitsVoting
	var channel_points_voting: ChannelPointsVoting
	var started_at: String
	var ends_at: String


	# Lifecyle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"bits_voting":
				return BitsVoting.new(_data)
			"channel_points_voting":
				return ChannelPointsVoting.new(_data)
			"choices":
				return Choice.new(_data)
			_:
				return null


class ChannelPollProgressEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const BitsVoting: Resource = preload("./shared.gd").BitsVoting
	const ChannelPointsVoting: Resource = preload("./shared.gd").ChannelPointsVoting
	const Choice: Resource = preload("./shared.gd").Choice


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var choices: Array
	var bits_voting: BitsVoting
	var channel_points_voting: ChannelPointsVoting
	var started_at: String
	var ends_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"bits_voting":
				return BitsVoting.new(_data)
			"channel_points_voting":
				return ChannelPointsVoting.new(_data)
			"choices":
				return Choice.new(_data)
			_:
				return null


class ChannelPollEndEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const BitsVoting: Resource = preload("./shared.gd").BitsVoting
	const ChannelPointsVoting: Resource = preload("./shared.gd").ChannelPointsVoting
	const Choice: Resource = preload("./shared.gd").Choice


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var choices: Array
	var bits_voting: BitsVoting
	var channel_points_voting: ChannelPointsVoting
	var status: String
	var started_at: String
	var ended_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"bits_voting":
				return BitsVoting.new(_data)
			"channel_points_voting":
				return ChannelPointsVoting.new(_data)
			"choices":
				return Choice.new(_data)
			_:
				return null


class ChannelPointsCustomRewardAddEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const GlobalCooldown: Resource = preload("./shared.gd").GlobalCooldown
	const ImageURL: Resource = preload("./shared.gd").ImageURL
	const MaxPerStream: Resource = preload("./shared.gd").MaxPerStream
	const MaxPerUserPerStream: Resource = preload("./shared.gd").MaxPerUserPerStream


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var is_enabled: bool
	var is_paused: bool
	var is_in_stock: bool
	var title: String
	var cost: int
	var prompt: String
	var is_user_input_required: bool
	var should_redemptions_skip_request_queue: bool
	var max_per_stream: MaxPerStream
	var max_per_user_per_stream: MaxPerUserPerStream
	var background_color: String
	var image: ImageURL
	var default_image: ImageURL
	var global_cooldown: GlobalCooldown
	var cooldown_expires_at: String
	var redemptions_redeemed_current_stream: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"max_per_stream":
				return MaxPerStream.new(_data)
			"max_per_user_per_stream":
				return MaxPerUserPerStream.new(_data)
			"image", "default_image":
				return ImageURL.new(_data)
			"global_cooldown":
				return GlobalCooldown.new(_data)
			_:
				return null


class ChannelPointsCustomRewardUpdateEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const GlobalCooldown: Resource = preload("./shared.gd").GlobalCooldown
	const ImageURL: Resource = preload("./shared.gd").ImageURL
	const MaxPerStream: Resource = preload("./shared.gd").MaxPerStream
	const MaxPerUserPerStream: Resource = preload("./shared.gd").MaxPerUserPerStream


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var is_enabled: bool
	var is_paused: bool
	var is_in_stock: bool
	var title: String
	var cost: int
	var prompt: String
	var is_user_input_required: bool
	var should_redemptions_skip_request_queue: bool
	var max_per_stream: MaxPerStream
	var max_per_user_per_stream: MaxPerUserPerStream
	var background_color: String
	var image: ImageURL
	var default_image: ImageURL
	var global_cooldown: GlobalCooldown
	var cooldown_expires_at: String
	var redemptions_redeemed_current_stream: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"max_per_stream":
				return MaxPerStream.new(_data)
			"max_per_user_per_stream":
				return MaxPerUserPerStream.new(_data)
			"image", "default_image":
				return ImageURL.new(_data)
			"global_cooldown":
				return GlobalCooldown.new(_data)
			_:
				return null


class ChannelPointsCustomRewardRemoveEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const GlobalCooldown: Resource = preload("./shared.gd").GlobalCooldown
	const ImageURL: Resource = preload("./shared.gd").ImageURL
	const MaxPerStream: Resource = preload("./shared.gd").MaxPerStream
	const MaxPerUserPerStream: Resource = preload("./shared.gd").MaxPerUserPerStream


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var is_enabled: bool
	var is_paused: bool
	var is_in_stock: bool
	var title: String
	var cost: int
	var prompt: String
	var is_user_input_required: bool
	var should_redemptions_skip_request_queue: bool
	var max_per_stream: MaxPerStream
	var max_per_user_per_stream: MaxPerUserPerStream
	var background_color: String
	var image: ImageURL
	var default_image: ImageURL
	var global_cooldown: GlobalCooldown
	var cooldown_expires_at: String
	var redemptions_redeemed_current_stream: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"max_per_stream":
				return MaxPerStream.new(_data)
			"max_per_user_per_stream":
				return MaxPerUserPerStream.new(_data)
			"image", "default_image":
				return ImageURL.new(_data)
			"global_cooldown":
				return GlobalCooldown.new(_data)
			_:
				return null


class ChannelPointsCustomRewardRedemptionAddEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Reward: Resource = preload("./shared.gd").Reward


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var user_id: String
	var user_login: String
	var user_name: String
	var user_input: String
	var status: String
	var reward: Reward
	var redeemed_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"reward":
				return Reward.new(_data)
			_:
				return null


class ChannelPointsCustomRewardRedemptionUpdateEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Reward: Resource = preload("./shared.gd").Reward


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var user_id: String
	var user_login: String
	var user_name: String
	var user_input: String
	var status: String
	var reward: Reward
	var redeemed_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"reward":
				return Reward.new(_data)
			_:
				return null


class ChannelPredictionBeginEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Outcome: Resource = preload("./shared.gd").Outcome


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var outcomes: Array
	var started_at: String
	var locks_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"outcomes":
				return Outcome.new(_data)
			_:
				return null


class ChannelPredictionProgressEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Outcome: Resource = preload("./shared.gd").Outcome


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var outcomes: Array
	var started_at: String
	var locks_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"outcomes":
				return Outcome.new(_data)
			_:
				return null


class ChannelPredictionLockEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Outcome: Resource = preload("./shared.gd").Outcome


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var outcomes: Array
	var started_at: String
	var locked_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"outcomes":
				return Outcome.new(_data)
			_:
				return null


class ChannelPredictionEndEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Outcome: Resource = preload("./shared.gd").Outcome


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var title: String
	var winning_outcome_id: String
	var outcomes: Array
	var status: String
	var started_at: String
	var ended_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"outcomes":
				return Outcome.new(_data)
			_:
				return null


class ChannelSubscriptionEndEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var tier: String
	var is_gift: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelSubscriptionGiftEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var total: int
	var tier: String
	var cumulative_total: int
	var is_anonymous: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelSubscriptionMessageEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Message: Resource = preload("./shared.gd").Message


	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var tier: String
	var message: Message
	var cumulative_months: int
	var streak_months: int
	var duration_months: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"message":
				return Message.new(_data)
			_:
				return null


class DropEntitlementGrantEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public classes

	class Data extends __Base:
		# Public variables

		var organization_id: String
		var category_id: String
		var category_name: String
		var campaign_id: String
		var user_id: String
		var user_name: String
		var user_login: String
		var entitlement_id: String
		var benefit_id: String
		var created_at: String


	# Public variables

	var id: String
	var data: Array


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"data":
				return Data.new(_data)
			_:
				return null


class ExtensionBitsTransactionCreateEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Product: Resource = preload("./shared.gd").Product


	# Public variables

	var extension_client_id: String
	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var user_id: String
	var user_login: String
	var user_name: String
	var product: Product


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"product":
				return Product.new(_data)
			_:
				return null


class GoalsEvent extends Event:
	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_name: String
	var broadcaster_user_login: String
	var type: String
	var description: String
	var is_achieved: bool
	var current_amount: int
	var target_amount: int
	var started_at: String
	var ended_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class HypeTrainBeginEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Contribution: Resource = preload("./shared.gd").Contribution


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var total: int
	var progress: int
	var goal: int
	var top_contributions: Array
	var last_contribution: Contribution
	var started_at: String
	var expires_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"last_contribution", "top_contributions":
				return Contribution.new(_data)
			_:
				return null


class HypeTrainProgressEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Contribution: Resource = preload("./shared.gd").Contribution


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var level: int
	var total: int
	var progress: int
	var goal: int
	var top_contributions: Array
	var last_contribution: Contribution
	var started_at: String
	var expires_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"last_contribution", "top_contributions":
				return Contribution.new(_data)
			_:
				return null


class HypeTrainEndEvent extends Event:
	# Private imports

	const __Base: Resource = preload("./shared.gd").__Base


	# Public imports

	const Contribution: Resource = preload("./shared.gd").Contribution


	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var level: int
	var total: int
	var top_contributions: Array
	var started_at: String
	var ended_at: String
	var cooldown_ends_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


	# Protected methods

	func _create_object(
		_type: String,
		_data: Dictionary
	) -> __Base:
		match _type:
			"top_contributions":
				return Contribution.new(_data)
			_:
				return null


class StreamOnlineEvent extends Event:
	# Public variables

	var id: String
	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String
	var type: String
	var started_at: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class StreamOfflineEvent extends Event:
	# Public variables

	var broadcaster_user_id: String
	var broadcaster_user_login: String
	var broadcaster_user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class UserAuthorizationGrantEvent extends Event:
	# Public variables

	var client_id: String
	var user_id: String
	var user_login: String
	var user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class UserAuthorizationRevokeEvent extends Event:
	# Public variables

	var client_id: String
	var user_id: String
	var user_login: String
	var user_name: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class UserUpdateEvent extends Event:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var email: String
	var description: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass
