extends Node2D

func _ready() -> void:
	Gloval.world = self


func _exit_tree() -> void:
	Gloval.world = null


func instamce_node(node, location):
	var node_inctance = node.instance()
	add_child(node_inctance)
	node_inctance = location
