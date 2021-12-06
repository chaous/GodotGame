extends RigidBody2D

export var vector_speed: = 1200.0
onready var arrow = $Arrow
onready var sprite = $toat


func _process(delta: float) -> void:
	var impulse: = canculate_impulse()
	apply_impulse(Vector2(), impulse)

func canculate_impulse() -> Vector2:
	var coll = get_colliding_bodies()
	if Input.is_action_just_pressed("stop") and (not coll.empty()):
		var angele : float = arrow.get_rotation()
		if angele < 0.0:
			sprite.flip_h = true
		elif angele != 0.0:
			sprite.flip_h = false
		return Vector2(
			vector_speed * sin(angele),
			vector_speed * (-cos(angele))
		)
	return Vector2()

func die() -> void:
	queue_free()
