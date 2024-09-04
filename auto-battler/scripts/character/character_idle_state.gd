class_name CharacterIdleState extends State


func transition(input: StateMachineInput) -> String:
	if "Dragging" in input.actions:
		return "Dragging"
	return name
