extends Actor

var par = load("res://str/addons/disapiring.tscn")
onready var plat = $platform
onready var time = $Timer
onready var sheder = load("res://str/addons/burn_shader.tres")


func _ready() -> void:
	plat.material = sheder.duplicate()
	plat.material.set_shader_param("duration", 2.0);



func _on_Area2D_area_entered(area: Area2D) -> void:
	#$AnimationPlayer.play("disapiring")
	time.start(2.4)
	plat.material.set_shader_param("start_time", OS.get_ticks_msec() / 1000)
	var dis_par = par.instance()
	add_child(dis_par)
	$Audio.play()


func die() -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	die()
