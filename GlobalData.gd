extends Node


var data = {
	"time_boust": 2.0,
	"time_kill": 5.0,
	"time_kill_bonus": 0.5,
	"time_kill_string": "recycle bonus %",
	"time_kill_percent": 0,
	"cost_time":  25,
	"speed_boust": 1000.0,
	"speed_boust_bonus": 100.0,
	"speed_boust_string": "speed bonus %",
	"speed_boust_persent": 0,
	"cost_speed": 25,
	"money": 0,
	"best_score": 0,
	"money_for_coin":  5,
	"money_for_coin_bonus": 1,
	"money_for_coin_string": "money bonus %",
	"money_for_coin_pesent": 0,
	"cost_money": 25,
	"vector_speed": 1200.0,
	"vector_speed_bonus": 12.0,
	"vector_speed_string": "jump bonus %",
	"vector_speed_persent": 0,
	"cost_jump": 25,
	"death_count": 0,
	"day": -1,
	"ads": true
}

var save_path = "user://save.dat"
#var time_boust: = 2.0
#var time_kill: = 5.0
#var time_kill_bonus: = 0.5
#var time_kill_string: = "recycle bonus %"
#var time_kill_percent: = 0
#var cost_time: = 25
#var speed_boust: = 1000.0
#var speed_boust_bonus: = 100.0
#var speed_boust_string: = "speed bonus %"
#var speed_boust_persent: = 0
#var cost_speed: = 25
#var money : int = 0
#var best_score : int = 0
#var money_for_coin : int = 5
#var money_for_coin_bonus : int = 1
#var money_for_coin_string: = "money bonus %"
#var money_for_coin_pesent: = 0
#var cost_money: = 25
#var vector_speed: = 1200.0
#var vector_speed_bonus: = 12.0
#var vector_speed_string: = "jump bonus %"
#var vector_speed_persent: = 0
#var cost_jump: = 25


func _ready():
	var file = File.new()
	if not file.file_exists(save_path):
		file.open_encrypted_with_pass(save_path, File.WRITE, "iliarojkov21")
		file.store_var(data)
		file.close()
	else:
		file.open_encrypted_with_pass(save_path, File.READ, "iliarojkov21")
		data = file.get_var()
		file.close()


