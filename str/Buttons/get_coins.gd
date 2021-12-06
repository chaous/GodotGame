extends Button



func _on_get_coins_pressed():
	#add ad
	GlobalData.data["money"] += 15
	var file = File.new()
	file.remove_meta(GlobalData.save_path)
	file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
	file.store_var(GlobalData.data)
	file.close()
