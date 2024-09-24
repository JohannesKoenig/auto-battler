class_name ExplorerCharacterSeekState extends State

var _boundary: Boundary
var _opponent_boundary: Boundary
var target: Vector2
var map_target: Vector2i
var has_target: bool = false
var at_target: bool = false
var movement_speed: float = 10
var safe_target_position: Vector2


func accept_navigation_agent(navigation_agent: NavigationAgent2D):
	_navigation_agent = navigation_agent
	_navigation_agent.velocity_computed.connect(_update_movement)

func transition(input: StateMachineInput) -> String:
	if not has_target:
		return "Idle"
	elif at_target:
		return "Explore"
	else:
		return input.actions[0]

func update(input: StateMachineInput):
	if has_target:
		_navigation_agent.target_position = target
		if _is_left(target):
			_rig.scale = Vector2(-1, 1)
		else:
			_rig.scale = Vector2(1, 1)
	else:
		_actor.velocity = Vector2.ZERO
	if Boundary.world_to_map(_actor.global_position) == map_target:
		at_target = true

func _physics_process(delta):
	if active:
		safe_target_position = _navigation_agent.get_next_path_position()
		var direction = (safe_target_position - _actor.global_position).normalized()
		var velocity = direction * movement_speed
		if "Slowed" in _buff_system.buffs:
			velocity /= 2
		_navigation_agent.velocity = velocity
		#_actor.velocity = velocity

func _update_movement(save_velocity: Vector2):
	if has_target:
		_actor.velocity = save_velocity
	else:
		_actor.velocity = Vector2.ZERO

func on_enter():
	at_target = false
	_boundary = BoundaryManager.get_boundary(_character.team)
	_opponent_boundary = BoundaryManager.get_boundary((_character.team + 1)%2)
	var map_coords = Boundary.world_to_map(_actor.global_position)
	var free_neighbours = _boundary.get_free_neighbours(map_coords)
	free_neighbours.shuffle()
	if len(free_neighbours) > 0:
		has_target = true
		map_target = _get_closest_coord(free_neighbours)
		target = Boundary.map_to_world(map_target)
	else:
		has_target = false
	super()

func _get_closest_coord(free_neighbours: Array[Vector2i]) -> Vector2i:
	var distance = 1000000
	var min_neighbour: Vector2i
	for neighbour in free_neighbours:
		var world_pos = Boundary.map_to_world(neighbour)
		var dist = (_actor.global_position - world_pos).length()
		if dist < distance:
			distance = dist
			min_neighbour = neighbour
	return min_neighbour

func on_exit():
	at_target = false
	has_target = false
	super()
