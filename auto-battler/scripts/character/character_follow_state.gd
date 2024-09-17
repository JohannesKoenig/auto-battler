class_name CharacterFollowState extends State

var movement_speed: float = 10


func update(input: StateMachineInput):
	if input is not CharacterInput:
		return
	var target = input.target
	if input.has_target:
		var direction = (target - _actor.global_position).normalized()
		var velocity = direction * movement_speed
		if "Slowed" in _buff_system.buffs:
			velocity /= 2
		_actor.velocity = velocity
		if _is_left(target):
			_rig.scale = Vector2(-1, 1)
		else:
			_rig.scale = Vector2(1, 1)
	else:
		_actor.velocity = Vector2.ZERO
