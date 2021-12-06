extends Label


var not_en_money = load("res://str/addons/NotEnoughtMoney.tscn")


func _ready():
	text = GlobalData.data["money_for_coin_string"] + String(GlobalData.data["money_for_coin_pesent"])
	$money2.text = String(GlobalData.data["cost_money"]) 



func _on_money2_pressed():
	if (GlobalData.data["money"] - GlobalData.data["cost_money"] >= 0):
		GlobalData.data["money"] -= GlobalData.data["cost_money"]
		GlobalData.data["money_for_coin"] += GlobalData.data["money_for_coin_bonus"]
		GlobalData.data["money_for_coin_pesent"] += 20
		text = GlobalData.data["money_for_coin_string"] + String(GlobalData.data["money_for_coin_pesent"])
		GlobalData.data["cost_money"] += 25 * GlobalData.data["money_for_coin_pesent"] / 10
		$money2.text = String(GlobalData.data["cost_money"])
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	else:
		get_parent().add_child(not_en_money.instance())
