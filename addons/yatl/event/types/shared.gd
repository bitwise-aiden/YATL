# Private classes

class __Base:
	# Lifecycle methods

	func _init(data: Dictionary) -> void:
		var properties: Dictionary = {}

		for property in get_property_list():
			properties[property['name']] = property['type']

		for property_name in data:
			if !properties.has(property_name):
				pass # TODO: Determine what happens here

			if properties[property_name] == TYPE_OBJECT:
				continue

			set(property_name, data[property_name])


# Public classes

class BitsVoting extends __Base:
	# Public variables

	var is_enabled: bool
	var amount_per_vote: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ChannelPointsVoting extends __Base:
	# Public variables

	var is_enabled: bool
	var amount_per_vote: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Choice extends __Base:
	# Public variables

	var id: String
	var title: String
	var bits_votes: int
	var channel_points_votes: int
	var votes: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Contribution extends __Base:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var type: String
	var total: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Emote extends __Base:
	# Public variables

	var begin: int
	var end: int
	var id: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class GlobalCooldown extends __Base:
	# Public variables

	var is_enabled: bool
	var seconds: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class ImageURL extends __Base:
	# Public variables

	var url_1x: String
	var url_2x: String
	var url_4x: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class MaxPerStream extends __Base:
	# Public variables

	var is_enabled: bool
	var value: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class MaxPerUserPerStream extends __Base:
	# Public variables

	var is_enabled: bool
	var value: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Message extends __Base:
	# Public variables

	var text: String
	var emotes: Array


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		emotes = []

		for emote in _data["emotes"]:
			emotes.append(Emote.new(emote))


class Outcome extends __Base:
	# Public variables

	var id: String
	var title: String
	var color: String
	var users: int
	var channel_points: int
	var top_predictors: Array


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		top_predictors = []

		for predictor in _data["top_predictors"]:
			top_predictors.append(Predictor.new(predictor))


class Predictor extends __Base:
	# Public variables

	var user_id: String
	var user_login: String
	var user_name: String
	var channel_points_won: int
	var channel_points_used: int


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Product extends __Base:
	# Public variables

	var name: String
	var bits: int
	var sku: String
	var in_development: bool


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass


class Reward extends __Base:
	# Public variables

	var id: String
	var title: String
	var cost: int
	var prompt: String


	# Lifecycle methods

	func _init(_data: Dictionary).(_data) -> void:
		pass
