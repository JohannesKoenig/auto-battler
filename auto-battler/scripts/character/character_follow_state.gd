class_name CharacterFollowState extends State

var movement_speed: float = 10

func transition(input: StateMachineInput) -> String:
	if "Dead" in input.actions:
		return "Dead"
	if "Dragging" in input.actions:
		return "Dragging"
	if "Shoot" in input.actions:
		return "Shoot"
	if "Slash" in input.actions:
		return "Slash"
	if name in input.actions:
		return name
	if "Idle" in input.actions:
		return "Idle"
	return name

func update(input: StateMachineInput):
	if input is not CharacterInput:
		return
	var target = input.target
	if input.has_target:
		var direction = (target - _actor.global_position).normalized()
		var velocity = direction * movement_speed
		_actor.velocity = velocity
		if _is_left(target):
			_rig.scale = Vector2(-1, 1)
		else:
			_rig.scale = Vector2(1, 1)
	else:
		_actor.velocity = Vector2.ZERO
