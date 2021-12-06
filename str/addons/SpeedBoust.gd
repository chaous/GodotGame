extends Area2D

onready var sp =$speed
onready var anim = $AnimationPlayer
onready var time = $Timer
onready var sheder = load("res://str/addons/burn_shader.tres")

func _ready() -> void:
	sp.material = sheder.duplicate()


func _on_SpeedBoust_area_entered(area: Area2D) -> void:
	time.start(2)
	sp.material.set_shader_param("start_time", OS.get_ticks_msec() / 1000)


func _on_SpeedBoust_body_entered(body: Node) -> void:
	body.boost = true
	anim.play("fade_in")
	$Audio.play()



func die():
	queue_free()


func _on_Timer_timeout() -> void:
	die()
