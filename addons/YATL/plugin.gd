tool
extends EditorPlugin


func _enter_tree():
	var output: Array = []
	OS.execute("ngrok", ["http", "3000"], false, output)

	print(output)


func _exit_tree():
	pass
