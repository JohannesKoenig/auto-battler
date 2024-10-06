class_name CharacterIdleState extends State

@export var duration: float = 1

func transition(input: StateMachineInput) -> String:
	if len(input.actions) > 0 and _has_passed(duration):
		return input.actions[0]
	return name

func update(input: StateMachineInput, delta: float):
	_actor.velocity = Vector2.ZERO

func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
