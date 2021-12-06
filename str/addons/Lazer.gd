extends Area2D

onready var sound: = get_node("Sound")
onready var ray = $RayCast2D
onready var line = $Line2D
onready var par = $Particles2D


func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		var coll_point = ray.get_collision_point()
		coll_point = to_local(coll_point)
		line.set_point_position(1, Vector2(0, coll_point.y))
		par.position = Vector2(0, coll_point.y)
		par.visible = true
	else:
		line.set_point_position(1, Vector2(0, 1000))
		par.visible = false
func _on_AudioStreamPlayer2D_finished() -> void:
	sound.play()



