class_name PickUpArea extends Area2D

var mouse_inside: bool = false
var dragging: bool = false
var dragging_target: Vector2
var injected: bool = false

func _on_mouse_entered():
	mouse_inside = true

func _on_mouse_exited():
	mouse_inside = false

func _process(delta):
	if Input.is_action_just_pressed("PickUp"):
		if not injected: 	
			if mouse_inside:
				dragging = true
			else: 
				dragging = false
			
	if Input.is_action_just_released("PickUp"):
		if not injected:
			dragging = false

	if dragging and not injected:
		dragging_target = get_viewport().get_mouse_position() + get_viewport().get_camera_2d().global_position

func inject_dragging(target: Vector2):
	injected = true
	dragging_target = target
	dragging = true

func break_dragging():
	injected = false
	dragging = false
