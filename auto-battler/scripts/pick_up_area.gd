class_name PickUpArea extends Area2D

var mouse_inside: bool = false
var dragging: bool = false
var dragging_target: Vector2


func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _process(delta):
	if dragging and not Input.is_action_pressed("PickUp"):
		dragging = false
		
	if mouse_inside and Input.is_action_pressed("PickUp"):
		dragging = true
	
	if dragging:
		dragging_target = get_viewport().get_mouse_position()
