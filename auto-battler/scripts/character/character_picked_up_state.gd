class_name CharacterDraggingState extends State


func transition(input: StateMachineInput) -> String:
	if input is not CharacterInput:
		return "Idle"

	if name in input.actions:
		_actor.position = input.dragging_target
		return name
	else:
		return "Idle"
