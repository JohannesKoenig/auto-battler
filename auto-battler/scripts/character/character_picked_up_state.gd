class_name CharacterDraggingState extends State

var _boundary: Boundary

func transition(input: StateMachineInput) -> String:
	if len(input.actions) > 0:
		return input.actions[0]
	return name

func update(input: StateMachineInput, delta: float):
	if input is CharacterInput and name in input.actions:
		var map_coords = Boundary.world_to_map(
			input.dragging_target
		)
		if _boundary.is_marked(map_coords):
			_actor.position = input.dragging_target
	
	_actor.velocity = Vector2.ZERO
	super(input, delta)

func on_enter():
	_boundary = BoundaryManager.get_boundary(_character.team)
	super()
