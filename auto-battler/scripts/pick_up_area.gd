class_name PickUpArea extends Area2D

var mouse_inside: bool = false
var dragging: bool = false
var dragging_target: Vector2


func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _process(delta):
	if Input.is_action_just_pressed("PickUp"):
		if mouse_inside:
			dragging = true
		else: 
			dragging = false
			
	if Input.is_action_just_released("PickUp"):
		dragging = false

	if dragging:
		dragging_target = get_viewport().get_mouse_position() + get_viewport().get_camera_2d().global_position
