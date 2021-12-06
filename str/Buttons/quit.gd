extends Button

func _on_Button_pressed():
	GlobalData.data["death_count"] += 1
	if GlobalData.data["death_count"] >= 5:
		GlobalData.data["death_count"] = 0
		#add %5 ads
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	get_tree().change_scene("res://str/Levels/MainMeny.tscn")
