extends Label

func _process(delta):
	text = "you have " + String(GlobalData.data["money"]) + " coins"
