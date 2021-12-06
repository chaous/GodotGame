extends KinematicBody2D
onready var time = $Timer
onready var sheder = load("res://str/addons/burn_shader.tres")
onready var coin = $coin



onready var anim_player: = get_node("AnimationPlayer")

func _ready() -> void:
	set_physics_process(false)
	anim_player.play("Bouncing")
	coin.material = sheder.duplicate()


func _on_Area2D_body_entered(body: Node) -> void:
	picked()

func picked():
	GlobalData.data["money"] += GlobalData.data["money_for_coin"]
	$Sound.play()
	anim_player.play("fade_in")



func _on_Area2D_area_entered(area):
	time.start(2)
	coin.material.set_shader_param("start_time", OS.get_ticks_msec() / 1000)


func _on_Timer_timeout():
	queue_free()
