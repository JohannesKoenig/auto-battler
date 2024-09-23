class_name ExplorerCharacterExploreState extends State

var _boundary: Boundary
var _opponent_boundary: Boundary
@export var duration: float = 3
var marked: bool = false

func transition(input: StateMachineInput) -> String:
	if marked:
		return "Idle"
	if "Dragging" in input.actions:
		return "Dragging"
	if "Dead" in input.actions:
		return "Dead"
	return "Explore"

func update(input: StateMachineInput):
	if _has_passed(duration):
		var map_coords = Boundary.world_to_map(_actor.global_position)
		_opponent_boundary.unmark(map_coords)
		_boundary.mark(map_coords)
		marked = true
	_actor.velocity = Vector2.ZERO

func on_enter():
	marked = false
	_boundary = BoundaryManager.get_boundary(_character.team)
	_opponent_boundary = BoundaryManager.get_boundary((_character.team + 1)%2)
	super()
