class_name CharacterStatus extends Node

@export var max_value: int
var current_value: int
@export var min_value: int = 0

func _ready():
	current_value = max_value
	pass
