extends KinematicBody2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	anim_player.play("Rotatin")


