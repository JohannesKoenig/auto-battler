class_name CharacterDraggingState extends State

var _boundary: Boundary

func update(input: StateMachineInput):
	if input is CharacterInput and name in input.actions:
		var map_coords = Boundary.world_to_map(
			get_viewport().get_mouse_position() + get_viewport().get_camera_2d().global_position
		)
		if _boundary.is_marked(map_coords):
			_actor.position = input.dragging_target
	
	_actor.velocity = Vector2.ZERO
	super(input)

func on_enter():
	_boundary = BoundaryManager.get_boundary(_character.team)
