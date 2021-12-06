extends Label

var not_en_money = load("res://str/addons/NotEnoughtMoney.tscn")


func _ready():
	text = GlobalData.data["time_kill_string"] + String(GlobalData.data["time_kill_percent"])
	$recucle2.text = String(GlobalData.data["cost_time"]) 


func _on_recucle2_pressed():
	if (GlobalData.data["money"] - GlobalData.data["cost_time"] >= 0):
		GlobalData.data["money"] -= GlobalData.data["cost_time"]
		GlobalData.data["time_kill"] += GlobalData.data["time_kill_bonus"]
		GlobalData.data["time_kill_percent"] += 10
		text = GlobalData.data["time_kill_string"] + String(GlobalData.data["time_kill_percent"])
		GlobalData.data["cost_time"] += 25 * GlobalData.data["time_kill_percent"] / 10
		$recucle2.text = String(GlobalData.data["cost_time"]) 
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	else:
		get_parent().add_child(not_en_money.instance())
