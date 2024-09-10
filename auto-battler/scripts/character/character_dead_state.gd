class_name CharacteDeadState extends State

var time_until_decay: float = 4
var should_be_despawned: bool = false

func transition(input: StateMachineInput) -> String:
	if _has_passed(time_until_decay):
		return "Death"
	return name

func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
