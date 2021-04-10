class_name InstantYield


signal completed()


func _init() -> void:
	self.emit_signal("completed")
	print("Hello?")
