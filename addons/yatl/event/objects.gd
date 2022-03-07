class Objects:
	class RequestFields:
		# Public variables

		var type: String
		var version: String
		var condition: Objects.Condition
		var transport: Objects.Transport


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			type = String(data["type"])
			version = String(data["version"])
			condition = Objects.Condition.new(data["condition"])
			transport = Objects.Transport.new(data["transport"])


	class ResponseFields:
		# Public variables

		var subscription: Objects.Subscription
		var event: Objects.Event


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			subscription = Objects.Subscription.new(data["subscription"])
			event = Objects.Event.new(data["event"])


	class BitsVoting:
		# Public variables

		var is_enabled: bool
		var amount_per_vote: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			is_enabled = bool(data["is_enabled"])
			amount_per_vote = int(data["amount_per_vote"])


	class ChannelPointsVoting:
		# Public variables

		var is_enabled: bool
		var amount_per_vote: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			is_enabled = bool(data["is_enabled"])
			amount_per_vote = int(data["amount_per_vote"])


	class Choices:
		# Public variables

		var id: String
		var title: String
		var bits_votes: int
		var channel_points_votes: int
		var votes: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			title = String(data["title"])
			bits_votes = int(data["bits_votes"])
			channel_points_votes = int(data["channel_points_votes"])
			votes = int(data["votes"])


	class Emotes:
		# Public variables

		var begin: int
		var end: int
		var id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			begin = int(data["begin"])
			end = int(data["end"])
			id = String(data["id"])


	class GlobalCooldown:
		# Public variables

		var is_enabled: bool
		var seconds: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			is_enabled = bool(data["is_enabled"])
			seconds = int(data["seconds"])


	class Image:
		# Public variables

		var url_1x: String
		var url_2x: String
		var url_4x: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			url_1x = String(data["url_1x"])
			url_2x = String(data["url_2x"])
			url_4x = String(data["url_4x"])


	class LastContribution:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var type: String
		var total: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			type = String(data["type"])
			total = int(data["total"])


	class MaxPerStream:
		# Public variables

		var is_enabled: bool
		var value: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			is_enabled = bool(data["is_enabled"])
			value = int(data["value"])


	class MaxPerUserPerStream:
		# Public variables

		var is_enabled: bool
		var value: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			is_enabled = bool(data["is_enabled"])
			value = int(data["value"])


	class Message:
		# Public variables

		var text: String
		var emotes: Objects.Emotes


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			text = String(data["text"])
			emotes = Objects.Emotes.new(data["emotes"])


	class Outcomes:
		# Public variables

		var id: String
		var title: String
		var color: String
		var users: int
		var channel_points: int
		var top_predictors: Objects.TopPredictors


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			title = String(data["title"])
			color = String(data["color"])
			users = int(data["users"])
			channel_points = int(data["channel_points"])
			top_predictors = Objects.TopPredictors.new(data["top_predictors"])


	class Product:
		# Public variables

		var name: String
		var bits: int
		var sku: String
		var in_development: bool


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			name = String(data["name"])
			bits = int(data["bits"])
			sku = String(data["sku"])
			in_development = bool(data["in_development"])


	class Reward:
		# Public variables

		var id: String
		var title: String
		var cost: int
		var prompt: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			title = String(data["title"])
			cost = int(data["cost"])
			prompt = String(data["prompt"])


	class Subscription:
		# Public variables

		var id: String
		var type: String
		var version: String
		var status: String
		var cost: int
		var condition: Objects.Condition
		var created_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			type = String(data["type"])
			version = String(data["version"])
			status = String(data["status"])
			cost = int(data["cost"])
			condition = Objects.Condition.new(data["condition"])
			created_at = String(data["created_at"])


	class TopContributions:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var type: String
		var total: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			type = String(data["type"])
			total = int(data["total"])


	class TopPredictors:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var channel_points_won: int
		var channel_points_used: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			channel_points_won = int(data["channel_points_won"])
			channel_points_used = int(data["channel_points_used"])


	class Transport:
		# Public variables

		var method: String
		var callback: String
		var secret: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			method = String(data["method"])
			callback = String(data["callback"])
			secret = String(data["secret"])


	class User:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])


class Conditions:
	class ChannelBanCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelSubscribeCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelSubscriptionEndCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelSubscriptionGiftCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelSubscriptionMessageCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelCheerCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelUpdateCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelFollowCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelUnbanCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelRaidCondition:
		# Public variables

		var from_broadcaster_user_id: String
		var to_broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			from_broadcaster_user_id = String(data["from_broadcaster_user_id"])
			to_broadcaster_user_id = String(data["to_broadcaster_user_id"])


	class ChannelModeratorAddCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelModeratorRemoveCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPointsCustomRewardAddCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPointsCustomRewardUpdateCondition:
		# Public variables

		var broadcaster_user_id: String
		var reward_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			reward_id = String(data["reward_id"])


	class ChannelPointsCustomRewardRemoveCondition:
		# Public variables

		var broadcaster_user_id: String
		var reward_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			reward_id = String(data["reward_id"])


	class ChannelPointsCustomRewardRedemptionAddCondition:
		# Public variables

		var broadcaster_user_id: String
		var reward_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			reward_id = String(data["reward_id"])


	class ChannelPointsCustomRewardRedemptionUpdateCondition:
		# Public variables

		var broadcaster_user_id: String
		var reward_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			reward_id = String(data["reward_id"])


	class ChannelPollBeginCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPollProgressCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPollEndCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPredictionBeginCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPredictionProgressCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPredictionLockCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class ChannelPredictionEndCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class DropEntitlementGrantCondition:
		# Public variables

		var organization_id: String
		var category_id: String
		var campaign_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			organization_id = String(data["organization_id"])
			category_id = String(data["category_id"])
			campaign_id = String(data["campaign_id"])


	class ExtensionBitsTransactionCreateCondition:
		# Public variables

		var extension_client_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			extension_client_id = String(data["extension_client_id"])


	class GoalsCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class HypeTrainBeginCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class HypeTrainProgressCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class HypeTrainEndCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class StreamOnlineCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class StreamOfflineCondition:
		# Public variables

		var broadcaster_user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])


	class UserAuthorizationGrantCondition:
		# Public variables

		var client_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			client_id = String(data["client_id"])


	class UserAuthorizationRevokeCondition:
		# Public variables

		var client_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			client_id = String(data["client_id"])


	class UserUpdateCondition:
		# Public variables

		var user_id: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])


class Events:
	class ChannelBanEvent:
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

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			moderator_user_id = String(data["moderator_user_id"])
			moderator_user_login = String(data["moderator_user_login"])
			moderator_user_name = String(data["moderator_user_name"])
			reason = String(data["reason"])
			ends_at = String(data["ends_at"])
			is_permanent = bool(data["is_permanent"])


	class ChannelSubscribeEvent:
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

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			tier = String(data["tier"])
			is_gift = bool(data["is_gift"])


	class ChannelCheerEvent:
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

		func _init(data: Dictionary) -> void:
			is_anonymous = bool(data["is_anonymous"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			message = String(data["message"])
			bits = int(data["bits"])


	class ChannelUpdateEvent:
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

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			language = String(data["language"])
			category_id = String(data["category_id"])
			category_name = String(data["category_name"])
			is_mature = bool(data["is_mature"])


	class ChannelUnbanEvent:
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

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			moderator_user_id = String(data["moderator_user_id"])
			moderator_user_login = String(data["moderator_user_login"])
			moderator_user_name = String(data["moderator_user_name"])


	class ChannelFollowEvent:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var followed_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			followed_at = String(data["followed_at"])


	class ChannelRaidEvent:
		# Public variables

		var from_broadcaster_user_id: String
		var from_broadcaster_user_login: String
		var from_broadcaster_user_name: String
		var to_broadcaster_user_id: String
		var to_broadcaster_user_login: String
		var to_broadcaster_user_name: String
		var viewers: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			from_broadcaster_user_id = String(data["from_broadcaster_user_id"])
			from_broadcaster_user_login = String(data["from_broadcaster_user_login"])
			from_broadcaster_user_name = String(data["from_broadcaster_user_name"])
			to_broadcaster_user_id = String(data["to_broadcaster_user_id"])
			to_broadcaster_user_login = String(data["to_broadcaster_user_login"])
			to_broadcaster_user_name = String(data["to_broadcaster_user_name"])
			viewers = int(data["viewers"])


	class ChannelModeratorAddEvent:
		# Public variables

		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var user_id: String
		var user_login: String
		var user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])


	class ChannelModeratorRemoveEvent:
		# Public variables

		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var user_id: String
		var user_login: String
		var user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])


	class ChannelPollBeginEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var choices: Objects.Choices
		var bits_voting: Objects.BitsVoting
		var channel_points_voting: Objects.ChannelPointsVoting
		var started_at: String
		var ends_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			choices = Objects.Choices.new(data["choices"])
			bits_voting = Objects.BitsVoting.new(data["bits_voting"])
			channel_points_voting = Objects.ChannelPointsVoting.new(data["channel_points_voting"])
			started_at = String(data["started_at"])
			ends_at = String(data["ends_at"])


	class ChannelPollProgressEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var choices: Objects.Choices
		var bits_voting: Objects.BitsVoting
		var channel_points_voting: Objects.ChannelPointsVoting
		var started_at: String
		var ends_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			choices = Objects.Choices.new(data["choices"])
			bits_voting = Objects.BitsVoting.new(data["bits_voting"])
			channel_points_voting = Objects.ChannelPointsVoting.new(data["channel_points_voting"])
			started_at = String(data["started_at"])
			ends_at = String(data["ends_at"])


	class ChannelPollEndEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var choices: Objects.Choices
		var bits_voting: Objects.BitsVoting
		var channel_points_voting: Objects.ChannelPointsVoting
		var status: String
		var started_at: String
		var ended_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			choices = Objects.Choices.new(data["choices"])
			bits_voting = Objects.BitsVoting.new(data["bits_voting"])
			channel_points_voting = Objects.ChannelPointsVoting.new(data["channel_points_voting"])
			status = String(data["status"])
			started_at = String(data["started_at"])
			ended_at = String(data["ended_at"])


	class ChannelPointsCustomRewardAddEvent:
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
		var max_per_stream: Objects.MaxPerStream
		var max_per_user_per_stream: Objects.MaxPerUserPerStream
		var background_color: String
		var image: image
		var default_image: image
		var global_cooldown: Objects.GlobalCooldown
		var cooldown_expires_at: String
		var redemptions_redeemed_current_stream: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			is_enabled = bool(data["is_enabled"])
			is_paused = bool(data["is_paused"])
			is_in_stock = bool(data["is_in_stock"])
			title = String(data["title"])
			cost = int(data["cost"])
			prompt = String(data["prompt"])
			is_user_input_required = bool(data["is_user_input_required"])
			should_redemptions_skip_request_queue = bool(data["should_redemptions_skip_request_queue"])
			max_per_stream = Objects.MaxPerStream.new(data["max_per_stream"])
			max_per_user_per_stream = Objects.MaxPerUserPerStream.new(data["max_per_user_per_stream"])
			background_color = String(data["background_color"])
			image = image.new(data["image"])
			default_image = image.new(data["default_image"])
			global_cooldown = Objects.GlobalCooldown.new(data["global_cooldown"])
			cooldown_expires_at = String(data["cooldown_expires_at"])
			redemptions_redeemed_current_stream = int(data["redemptions_redeemed_current_stream"])


	class ChannelPointsCustomRewardUpdateEvent:
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
		var max_per_stream: Objects.MaxPerStream
		var max_per_user_per_stream: Objects.MaxPerUserPerSteram
		var background_color: String
		var image: image
		var default_image: image
		var global_cooldown: Objects.GlobalCooldown
		var cooldown_expires_at: String
		var redemptions_redeemed_current_stream: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			is_enabled = bool(data["is_enabled"])
			is_paused = bool(data["is_paused"])
			is_in_stock = bool(data["is_in_stock"])
			title = String(data["title"])
			cost = int(data["cost"])
			prompt = String(data["prompt"])
			is_user_input_required = bool(data["is_user_input_required"])
			should_redemptions_skip_request_queue = bool(data["should_redemptions_skip_request_queue"])
			max_per_stream = Objects.MaxPerStream.new(data["max_per_stream"])
			max_per_user_per_stream = Objects.MaxPerUserPerSteram.new(data["max_per_user_per_stream"])
			background_color = String(data["background_color"])
			image = image.new(data["image"])
			default_image = image.new(data["default_image"])
			global_cooldown = Objects.GlobalCooldown.new(data["global_cooldown"])
			cooldown_expires_at = String(data["cooldown_expires_at"])
			redemptions_redeemed_current_stream = int(data["redemptions_redeemed_current_stream"])


	class ChannelPointsCustomRewardRemoveEvent:
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
		var max_per_stream: Objects.MaxPerStream
		var max_per_user_per_stream: Objects.MaxPerUserPerSteram
		var background_color: String
		var image: image
		var default_image: image
		var global_cooldown: Objects.GlobalCooldown
		var cooldown_expires_at: String
		var redemptions_redeemed_current_stream: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			is_enabled = bool(data["is_enabled"])
			is_paused = bool(data["is_paused"])
			is_in_stock = bool(data["is_in_stock"])
			title = String(data["title"])
			cost = int(data["cost"])
			prompt = String(data["prompt"])
			is_user_input_required = bool(data["is_user_input_required"])
			should_redemptions_skip_request_queue = bool(data["should_redemptions_skip_request_queue"])
			max_per_stream = Objects.MaxPerStream.new(data["max_per_stream"])
			max_per_user_per_stream = Objects.MaxPerUserPerSteram.new(data["max_per_user_per_stream"])
			background_color = String(data["background_color"])
			image = image.new(data["image"])
			default_image = image.new(data["default_image"])
			global_cooldown = Objects.GlobalCooldown.new(data["global_cooldown"])
			cooldown_expires_at = String(data["cooldown_expires_at"])
			redemptions_redeemed_current_stream = int(data["redemptions_redeemed_current_stream"])


	class ChannelPointsCustomRewardRedemptionAddEvent:
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
		var reward: Objects.Reward
		var redeemed_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			user_input = String(data["user_input"])
			status = String(data["status"])
			reward = Objects.Reward.new(data["reward"])
			redeemed_at = String(data["redeemed_at"])


	class ChannelPointsCustomRewardRedemptionUpdateEvent:
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
		var reward: Objects.Reward
		var redeemed_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			user_input = String(data["user_input"])
			status = String(data["status"])
			reward = Objects.Reward.new(data["reward"])
			redeemed_at = String(data["redeemed_at"])


	class ChannelPredictionBeginEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var outcomes: Objects.Outcomes
		var started_at: String
		var locks_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			outcomes = Objects.Outcomes.new(data["outcomes"])
			started_at = String(data["started_at"])
			locks_at = String(data["locks_at"])


	class ChannelPredictionProgressEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var outcomes: Objects.Outcomes
		var started_at: String
		var locks_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			outcomes = Objects.Outcomes.new(data["outcomes"])
			started_at = String(data["started_at"])
			locks_at = String(data["locks_at"])


	class ChannelPredictionLockEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var outcomes: Objects.Outcomes
		var started_at: String
		var locked_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			outcomes = Objects.Outcomes.new(data["outcomes"])
			started_at = String(data["started_at"])
			locked_at = String(data["locked_at"])


	class ChannelPredictionEndEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var title: String
		var winning_outcome_id: String
		var outcomes: Objects.Outcomes
		var status: String
		var started_at: String
		var ended_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			title = String(data["title"])
			winning_outcome_id = String(data["winning_outcome_id"])
			outcomes = Objects.Outcomes.new(data["outcomes"])
			status = String(data["status"])
			started_at = String(data["started_at"])
			ended_at = String(data["ended_at"])


	class ChannelSubscriptionEndEvent:
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

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			tier = String(data["tier"])
			is_gift = bool(data["is_gift"])


	class ChannelSubscriptionGiftEvent:
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

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			total = int(data["total"])
			tier = String(data["tier"])
			cumulative_total = int(data["cumulative_total"])
			is_anonymous = bool(data["is_anonymous"])


	class ChannelSubscriptionMessageEvent:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var tier: String
		var message: Objects.Message
		var cumulative_months: int
		var streak_months: int
		var duration_months: int


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			tier = String(data["tier"])
			message = Objects.Message.new(data["message"])
			cumulative_months = int(data["cumulative_months"])
			streak_months = int(data["streak_months"])
			duration_months = int(data["duration_months"])


	class DropEntitlementGrantEvent:
		# Public classes

		class Data:
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


			# Lifecycle methods

			func _init(data: Dictionary) -> void:
				organization_id = String(data["organization_id"])
				category_id = String(data["category_id"])
				category_name = String(data["category_name"])
				campaign_id = String(data["campaign_id"])
				user_id = String(data["user_id"])
				user_name = String(data["user_name"])
				user_login = String(data["user_login"])
				entitlement_id = String(data["entitlement_id"])
				benefit_id = String(data["benefit_id"])
				created_at = String(data["created_at"])


		# Public variables

		var id: String
		var data: Array


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			data = []
			for value in data["field_name"]:
				data.append(Data.new(value))


	class ExtensionBitsTransactionCreateEvent:
		# Public variables

		var extension_client_id: String
		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var user_id: String
		var user_login: String
		var user_name: String
		var product: Objects.Product


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			extension_client_id = String(data["extension_client_id"])
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			product = Objects.Product.new(data["product"])


	class GoalsEvent:
		# Public variables

		var id: Objects.String
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

		func _init(data: Dictionary) -> void:
			id = Objects.String.new(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			type = String(data["type"])
			description = String(data["description"])
			is_achieved = bool(data["is_achieved"])
			current_amount = int(data["current_amount"])
			target_amount = int(data["target_amount"])
			started_at = String(data["started_at"])
			ended_at = String(data["ended_at"])


	class HypeTrainBeginEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var total: int
		var progress: int
		var goal: int
		var top_contributions: Objects.TopContributions
		var last_contribution: Objects.LastContribution
		var started_at: String
		var expires_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			total = int(data["total"])
			progress = int(data["progress"])
			goal = int(data["goal"])
			top_contributions = Objects.TopContributions.new(data["top_contributions"])
			last_contribution = Objects.LastContribution.new(data["last_contribution"])
			started_at = String(data["started_at"])
			expires_at = String(data["expires_at"])


	class HypeTrainProgressEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var level: int
		var total: int
		var progress: int
		var goal: int
		var top_contributions: Objects.TopContributions
		var last_contribution: Objects.LastContribution
		var started_at: String
		var expires_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			level = int(data["level"])
			total = int(data["total"])
			progress = int(data["progress"])
			goal = int(data["goal"])
			top_contributions = Objects.TopContributions.new(data["top_contributions"])
			last_contribution = Objects.LastContribution.new(data["last_contribution"])
			started_at = String(data["started_at"])
			expires_at = String(data["expires_at"])


	class HypeTrainEndEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var level: int
		var total: int
		var top_contributions: Objects.TopContributions
		var started_at: String
		var ended_at: String
		var cooldown_ends_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			level = int(data["level"])
			total = int(data["total"])
			top_contributions = Objects.TopContributions.new(data["top_contributions"])
			started_at = String(data["started_at"])
			ended_at = String(data["ended_at"])
			cooldown_ends_at = String(data["cooldown_ends_at"])


	class StreamOnlineEvent:
		# Public variables

		var id: String
		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String
		var type: String
		var started_at: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			id = String(data["id"])
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])
			type = String(data["type"])
			started_at = String(data["started_at"])


	class StreamOfflineEvent:
		# Public variables

		var broadcaster_user_id: String
		var broadcaster_user_login: String
		var broadcaster_user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			broadcaster_user_id = String(data["broadcaster_user_id"])
			broadcaster_user_login = String(data["broadcaster_user_login"])
			broadcaster_user_name = String(data["broadcaster_user_name"])


	class UserAuthorizationGrantEvent:
		# Public variables

		var client_id: String
		var user_id: String
		var user_login: String
		var user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			client_id = String(data["client_id"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])


	class UserAuthorizationRevokeEvent:
		# Public variables

		var client_id: String
		var user_id: String
		var user_login: String
		var user_name: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			client_id = String(data["client_id"])
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])


	class UserUpdateEvent:
		# Public variables

		var user_id: String
		var user_login: String
		var user_name: String
		var email: String
		var description: String


		# Lifecycle methods

		func _init(data: Dictionary) -> void:
			user_id = String(data["user_id"])
			user_login = String(data["user_login"])
			user_name = String(data["user_name"])
			email = String(data["email"])
			description = String(data["description"])


