extends Button

func _on_Button_pressed():
	var pause = load("res://str/Levels/Pause.tscn")
	var paus_node = pause.instance()
	get_parent().add_child(paus_node)
