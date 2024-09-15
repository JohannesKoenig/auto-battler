class_name CharacterIdleState extends State


func transition(input: StateMachineInput) -> String:
	if "Dead" in input.actions:
		return "Dead"
	if "Shoot" in input.actions:
		return "Shoot"
	if "Slash" in input.actions:
		return "Slash"
	if "Follow" in input.actions:
		return "Follow"
	if "Dragging" in input.actions:
		return "Dragging"
	return name

func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
