extends Node

var target: Node

func spawn(character: Node):
	if target != null:
		target.add_child(character)
