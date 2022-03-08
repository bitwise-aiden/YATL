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
		bits_voting = BitsVoting.new(_data["bits_voting"])
		channel_points_voting = ChannelPointsVoting.new(_data["channe_points_voting"])

		choices = []

		for choice in _data["choices"]:
			choices.append(Choice.new(choice))


class ChannelPollProgressEvent extends Event:
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
		bits_voting = BitsVoting.new(_data["bits_voting"])
		channel_points_voting = ChannelPointsVoting.new(_data["channe_points_voting"])

		choices = []

		for choice in _data["choices"]:
			choices.append(Choice.new(choice))


class ChannelPollEndEvent extends Event:
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
		bits_voting = BitsVoting.new(_data["bits_voting"])
		channel_points_voting = ChannelPointsVoting.new(_data["channe_points_voting"])

		choices = []

		for choice in _data["choices"]:
			choices.append(Choice.new(choice))


class ChannelPointsCustomRewardAddEvent extends Event:
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
		max_per_stream = MaxPerStream.new(_data["max_per_stream"])
		max_per_user_per_stream = MaxPerUserPerStream.new(_data["max_per_user_per_stream"])
		image = ImageURL.new(_data["image"])
		default_image = ImageURL.new(_data["default_image"])
		global_cooldown = GlobalCooldown.new(_data["global_cooldown"])


class ChannelPointsCustomRewardUpdateEvent extends Event:
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
		max_per_stream = MaxPerStream.new(_data["max_per_stream"])
		max_per_user_per_stream = MaxPerUserPerStream.new(_data["max_per_user_per_stream"])
		image = ImageURL.new(_data["image"])
		default_image = ImageURL.new(_data["default_image"])
		global_cooldown = GlobalCooldown.new(_data["global_cooldown"])


class ChannelPointsCustomRewardRemoveEvent extends Event:
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
		max_per_stream = MaxPerStream.new(_data["max_per_stream"])
		max_per_user_per_stream = MaxPerUserPerStream.new(_data["max_per_user_per_stream"])
		image = ImageURL.new(_data["image"])
		default_image = ImageURL.new(_data["default_image"])
		global_cooldown = GlobalCooldown.new(_data["global_cooldown"])


class ChannelPointsCustomRewardRedemptionAddEvent extends Event:
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
		reward = Reward.new(_data["reward"])


class ChannelPointsCustomRewardRedemptionUpdateEvent extends Event:
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
		reward = Reward.new(_data["reward"])


class ChannelPredictionBeginEvent extends Event:
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
		outcomes = []

		for outcome in _data["outcomes"]:
			outcomes.append(Outcome.new(outcome))


class ChannelPredictionProgressEvent extends Event:
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
		outcomes = []

		for outcome in _data["outcomes"]:
			outcomes.append(Outcome.new(outcome))


class ChannelPredictionLockEvent extends Event:
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
		outcomes = []

		for outcome in _data["outcomes"]:
			outcomes.append(Outcome.new(outcome))


class ChannelPredictionEndEvent extends Event:
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
		outcomes = []

		for outcome in _data["outcomes"]:
			outcomes.append(Outcome.new(outcome))


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
		message = Message.new(_data["message"])


class DropEntitlementGrantEvent extends Event:
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
		data = []

		for raw_data in _data['data']:
			data.append(Data.new(raw_data))


class ExtensionBitsTransactionCreateEvent extends Event:
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
		product = Product.new(_data["product"])


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
		last_contribution = Contribution.new(_data["last_contribution"])

		top_contributions = []

		for contribution in _data["top_contributions"]:
			top_contributions.append(Contribution.new(contribution))


class HypeTrainProgressEvent extends Event:
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
		last_contribution = Contribution.new(_data["last_contribution"])

		top_contributions = []

		for contribution in _data["top_contributions"]:
			top_contributions.append(Contribution.new(contribution))


class HypeTrainEndEvent extends Event:
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
		top_contributions = []

		for contribution in _data["top_contributions"]:
			top_contributions.append(Contribution.new(contribution))


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
