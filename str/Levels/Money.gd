extends Label
var revard = load("res://str/addons/Come_next_day.tscn")


func _process(delta):
	text = String(GlobalData.data["money"])
	if OS.get_date()["day"] != GlobalData.data["day"]:
		GlobalData.data["day"] = OS.get_date()["day"]
		GlobalData.data["money"] += 20
		get_parent().add_child(revard.instance())
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
