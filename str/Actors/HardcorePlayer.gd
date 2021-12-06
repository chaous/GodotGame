extends Actor

onready var arrow: = get_node("Arrow") 
onready var sprite: = get_node("toat")
onready var picture = $toat
onready var colision = $CollisionPolygon2D
var screen = InputEventScreenTouch.new()
var boost: = false
var first_step: = true
var particals = load("res://str/addons/Forsce_up.tscn")
var par_up : Particles2D
var par_line : Particles2D
var particals_line = load("res://str/addons/line_par.tscn")
onready var timer = $Timer
var time_out: = false
signal spawn_platform
onready var animation = $AnimationPlayer
var killing_enamis: = false
onready var timer_kill = $TimerRec
onready var lazer = $KinematicBody2D
onready var dis_lazer = lazer.position.x - position.x
onready var score_lengh = $Control/Label



func _physics_process(delta: float) -> void:
	score_lengh.text = String(int(global_position.x / 160))
	if boost:
		fly_up()
		return
	if time_out:
		fly_by_line()
		return
	_velocity = get_velosity(_velocity)
	if _velocity.x < 0:
		lazer.move_and_slide(Vector2(-_velocity.x, 0), FLOOR_NORMAL)
	if _velocity.x == 0:
		picture.rotation = 0
		colision.rotation = 0
	else:
		picture.rotation = atan2(_velocity.y, _velocity.x)
		if _velocity.y > 50.1:
			colision.rotation = atan2(_velocity.y, _velocity.x)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)





func die() -> void:
	if int(score_lengh.text) > GlobalData.data["best_score"]:
		GlobalData.data["best_score"] = int(score_lengh.text) 
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
	#queue_free()
	GlobalData.data["death_count"] += 1
	if GlobalData.data["death_count"] >= 5:
		GlobalData.data["death_count"] = 0
		var file = File.new()
		file.remove_meta(GlobalData.save_path)
		file.open_encrypted_with_pass(GlobalData.save_path, File.WRITE, "iliarojkov21")
		file.store_var(GlobalData.data)
		file.close()
		#add %5 ads
	get_tree().change_scene("res://str/Levels/DeathMeny.tscn")


func get_velosity(
	linear_valicity: Vector2
) -> Vector2:
	if (Input.is_action_just_pressed("stop") or screen.pressed) and is_on_floor():
		var angele : float = arrow.get_rotation()
		if angele < 0.0:
			sprite.flip_h = true
		elif angele != 0.0:
			sprite.flip_h = false
		return Vector2(
			GlobalData.data["vector_speed"] * sin(angele),
			GlobalData.data["vector_speed"] * (-cos(angele))
		)
	var out: = linear_valicity
	if is_on_floor():
		out.x = 0
	out.y += gravity * get_physics_process_delta_time()
	return out


func fly_up():
	if first_step:
		picture.rotation = 0
		colision.rotation = 0
		par_up = particals.instance()
		add_child(par_up)
		first_step = false
		_velocity.x = 0
		_velocity.y = -100
	_velocity = move_and_slide(_velocity)
	if _velocity.y == 0:
		_velocity.y = -100
	if global_position.y < -190:
		boost = false
		first_step = true
		par_up.queue_free()
		time_out = true
		timer.start(GlobalData.data["time_boust"])

func fly_by_line():
	if first_step:
		first_step = false
		_velocity.y = 0.0
		_velocity.x = GlobalData.data["speed_boust"]
		par_line = particals_line.instance()
		add_child(par_line)
	_velocity = move_and_slide(_velocity)
	


func _on_Timer_timeout() -> void:
	time_out = false
	par_line.queue_free()
	timer.stop()
	first_step =true
	emit_signal("spawn_platform")


func _on_TimerRec_timeout() -> void:
	killing_enamis = false
	animation.stop()
	picture.modulate = Color(1, 1, 1, 1)
	timer_kill.stop()




func _on_DetectorLazer_area_entered(area):
	die()


func _on_Detector_area_entered(area):
	if killing_enamis:
		area.queue_free()
		GlobalData.data["money"] += int(GlobalData.data["money_for_coin"] / 2)
	else:
		die()
