# Private imports

const __DataType: Resource = preload("res://addons/yatl/pal/pal.gd").DataType


# Public classes

class BitsVoting extends __DataType:
	# Public variables

	var is_enabled: bool
	var amount_per_vote: int


class ChannelPointsVoting extends __DataType:
	# Public variables

	var is_enabled: bool
	var amount_per_vote: int


class Choice extends __DataType:
	# Public variables

	var id: String
	var title: String
	var bits_votes: int
	var channel_points_votes: int
	var votes: int


class Contribution extends __DataType:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var type: String
	var total: int


class Emote extends __DataType:
	# Public variables

	var begin: int
	var end: int
	var id: String


class GlobalCooldown extends __DataType:
	# Public variables

	var is_enabled: bool
	var seconds: int


class ImageURL extends __DataType:
	# Public variables

	var url_1x: String
	var url_2x: String
	var url_4x: String


class MaxPerStream extends __DataType:
	# Public variables

	var is_enabled: bool
	var value: int


class MaxPerUserPerStream extends __DataType:
	# Public variables

	var is_enabled: bool
	var value: int


class Message extends __DataType:
	# Public imports

	# TODO: Figure out how to import emotes


	# Public variables

	var text: String
	var emotes: Array


class Outcome extends __DataType:
	# Public imports

	# TODO: Figure out how to import predictors


	# Public variables

	var id: String
	var title: String
	var color: String
	var users: int
	var channel_points: int
	var top_predictors: Array


class Predictor extends __DataType:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var channel_points_won: int
	var channel_points_used: int


class Product extends __DataType:
	# Public variables

	var name: String
	var bits: int
	var sku: String
	var in_development: bool


class Reward extends __DataType:
	# Public variables

	var id: String
	var title: String
	var cost: int
	var prompt: String
