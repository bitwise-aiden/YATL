var sender: String
var message: String
var channel: String


func _init(sender: String, message: String, channel: String) -> void:
	self.sender = sender
	self.message = message
	self.channel = channel


func to_dict() -> Dictionary:
	return {"sender": sender, "message": message, "channel": channel}
