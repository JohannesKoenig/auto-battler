class_name PickUpArea extends Area2D

var mouse_inside: bool = false
var dragging: bool = false
var dragging_target: Vector2


func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func validate_input(input: CharacterInput) -> CharacterInput:
	if "PickUp" in input.actions:
		if mouse_inside:
			dragging = true
		else: 
			dragging = false
			
	if "Drop" in input.actions:
		dragging = false

	if dragging:
		input.dragging_target = get_viewport().get_mouse_position()
	else:
		var index = input.actions.find("Dragging")
		if index > 0:
			input.actions.remove_at(index)	
	return input
	
