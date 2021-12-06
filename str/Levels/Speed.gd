extends Label


var not_en_money = load("res://str/addons/NotEnoughtMoney.tscn")


func _ready():
	text = GlobalData.data["speed_boust_string"] + String(GlobalData.data["speed_boust_persent"])
	$speed2.text = String(GlobalData.data["cost_speed"]) 




func _on_speed2_pressed():
	if (GlobalData.data["money"] - GlobalData.data["cost_speed"] >= 0):
		GlobalData.data["money"] -= GlobalData.data["cost_speed"]
		GlobalData.data["speed_boust"] += GlobalData.data["speed_boust_bonus"]
		GlobalData.data["speed_boust_persent"] += 10
		text = GlobalData.data["speed_boust_string"] + String(GlobalData.data["speed_boust_persent"])
		GlobalData.data["cost_speed"] += 25 * GlobalData.data["speed_boust_persent"] / 10
		$speed2.text = String(GlobalData.data["cost_speed"]) 
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	else:
		get_parent().add_child(not_en_money.instance())



