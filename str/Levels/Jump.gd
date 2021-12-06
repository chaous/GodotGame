extends Label

var not_en_money = load("res://str/addons/NotEnoughtMoney.tscn")

func _ready():
	text = GlobalData.data["vector_speed_string"] + String(GlobalData.data["vector_speed_persent"])
	$jump.text = String(GlobalData.data["cost_jump"]) 


func _on_jump_pressed():
	if (GlobalData.data["money"] - GlobalData.data["cost_jump"] >= 0):
		GlobalData.data["money"] -= GlobalData.data["cost_jump"]
		GlobalData.data["vector_speed"] += GlobalData.data["vector_speed_bonus"]
		GlobalData.data["vector_speed_persent"] += 1
		text = GlobalData.data["vector_speed_string"] + String(GlobalData.data["vector_speed_persent"])
		GlobalData.data["cost_jump"] += 25 * GlobalData.data["vector_speed_persent"]
		$jump.text = String(GlobalData.data["cost_jump"])
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	else:
		get_parent().add_child(not_en_money.instance())
