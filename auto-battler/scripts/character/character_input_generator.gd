class_name CharacterInputGenerator extends Node2D


@onready var pick_up_area: PickUpArea = $PickUpArea

func get_input() -> CharacterInput:
	return CharacterInput.new()
	
