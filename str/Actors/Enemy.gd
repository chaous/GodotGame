extends KinematicBody2D


onready var anim_player := get_node("AnimationPlayer")
onready var time = $Timer
onready var sheder = load("res://str/addons/burn_shader.tres")



func _ready() -> void:
	anim_player.play("Size_changing")
	$Bottle.material = sheder.duplicate()

func _on_Area2D_area_entered(area: Area2D) -> void:
	time.start(2)
	$Bottle.material.set_shader_param("start_time", OS.get_ticks_msec() / 1000)
	$Audio.play()

func die() -> void:
	queue_free()


func _on_Timer_timeout():
	die()



func _on_Area2D_body_entered(body):
	queue_free()
