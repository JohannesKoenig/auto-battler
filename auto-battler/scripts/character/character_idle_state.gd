class_name CharacterIdleState extends State


func transition(input: StateMachineInput) -> String:
	if "Dead" in input.actions:
		return "Dead"
	if "Dragging" in input.actions:
		return "Dragging"
	return name
