class_name GameCamera extends Camera2D

var scroll_width: int = 4
var width: int
var height: int

func _ready():
	var rect = get_viewport_rect()
	width = rect.size.x
	height = rect.size.y
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _process(delta):
	var mouse_position = get_local_mouse_position()
	var to_right = width - mouse_position.x
	var to_left = mouse_position.x
	var to_top = mouse_position.y
	var to_bottom = height - mouse_position.y
	
	var velocity = Vector2.ZERO
	if _should_scroll(to_right) or Input.is_action_pressed("Right"):
		velocity += Vector2.RIGHT
	elif _should_scroll(to_left) or Input.is_action_pressed("Left"):
		velocity += Vector2.LEFT
	if _should_scroll(to_top) or Input.is_action_pressed("Up"):
		velocity += Vector2.UP
	elif _should_scroll(to_bottom) or Input.is_action_pressed("Down"):
		velocity += Vector2.DOWN
	

	position += delta * velocity.normalized() * 100

func _should_scroll(distance: float) -> bool:
	return distance > 0 and distance <= scroll_width
	
