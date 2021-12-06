extends Actor

onready var sprite: = get_node("toat")


func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	if direction.x < 0.0:
		sprite.flip_h = true
	elif direction.x != 0.0:
		sprite.flip_h = false	
	_velocity = canculate_move_velicitu(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		-1.0 if  Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func canculate_move_velicitu(
	linear_valicity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var out: = linear_valicity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	return out
