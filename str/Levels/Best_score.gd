extends Label

func _process(delta):
	text = "best score " + String(GlobalData.data["best_score"])
