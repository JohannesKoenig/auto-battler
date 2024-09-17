class_name CharacterDraggingState extends State


func transition(input: StateMachineInput) -> String:
	if input is CharacterInput and name in input.actions:
		_actor.position = input.dragging_target
	
	return super(input)
