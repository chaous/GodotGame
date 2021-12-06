extends Area2D
onready var time = $Timer
onready var sheder = load("res://str/addons/burn_shader.tres")


func _ready() -> void:
	$AnimationPlayer.play("rotating")
	$recucle.material = sheder.duplicate()


func _on_Recucle_area_entered(area: Area2D) -> void:
	time.start(2)
	$recucle.material.set_shader_param("start_time", OS.get_ticks_msec() / 1000)


func _on_Recucle_body_entered(body: Node) -> void:
	body.animation.play("color_changing")
	body.killing_enamis = true
	body.timer_kill.start(GlobalData.data["time_kill"])
	$AnimationPlayer.play("fade_in")
	$Audio.play()


func die():
	queue_free()


func _on_Timer_timeout():
	die()
