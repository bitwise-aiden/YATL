tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("YATL", "Node", preload("yatl.gd"), preload("yatl_icon.png"))


func _exit_tree():
	remove_custom_type("YATL")
