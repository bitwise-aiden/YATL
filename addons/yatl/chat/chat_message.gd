var sender: String
var message: String
var channel: String
var tags: Dictionary


func _init(sender: String, message: String, channel: String, tags: Dictionary) -> void:
	self.sender = sender
	self.message = message
	self.channel = channel
	self.tags = tags


func to_dict() -> Dictionary:
	return {"sender": sender, "message": message, "channel": channel, "tags": tags}
