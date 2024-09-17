class_name CharacteDeadState extends State

var time_until_decay: float = 4
var should_be_despawned: bool = false

func transition(input: StateMachineInput) -> String:
	if _has_passed(time_until_decay):
		return "Death"
	return name

func on_enter():
	_actor.velocity = Vector2.ZERO
	_actor.set_collision_mask_value(1, false) 
	_actor.set_collision_layer_value(1, false)
	_hurtbox.set_collision_layer_value(12, false)
	_hurtbox.set_collision_mask_value(11, false)
	super()

func update(input: StateMachineInput):
	_actor.velocity = Vector2.ZERO
