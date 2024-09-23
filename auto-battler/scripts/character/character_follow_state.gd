class_name CharacterFollowState extends State

var movement_speed: float = 10
var safe_target_position: Vector2
var target: Vector2
var has_target: bool = false



func accept_navigation_agent(navigation_agent: NavigationAgent2D):
	_navigation_agent = navigation_agent
	_navigation_agent.velocity_computed.connect(_update_movement)


func update(input: StateMachineInput):
	if input is not CharacterInput:
		return
	target = input.target
	has_target = input.has_target
	if input.has_target:
		_navigation_agent.target_position = target
		if _is_left(target):
			_rig.scale = Vector2(-1, 1)
		else:
			_rig.scale = Vector2(1, 1)
	else:
		_actor.velocity = Vector2.ZERO

func _physics_process(delta):
	if active:
		safe_target_position = _navigation_agent.get_next_path_position()
		var direction = (safe_target_position - _actor.global_position).normalized()
		var velocity = direction * movement_speed
		if "Slowed" in _buff_system.buffs:
			velocity /= 2
		_navigation_agent.velocity = velocity

func _update_movement(save_velocity: Vector2):
	if has_target:
		_actor.velocity = save_velocity
	else:
		_actor.velocity = Vector2.ZERO
