class_name CoolDownValidator extends Node

func validate(input: CharacterInput, states: Dictionary) -> CharacterInput:
	var valid_actions: Array[String] = []
	for action in input.actions:
		var state = states[action]
		if not state.on_cool_down():
			valid_actions.append(action)
	input.actions = valid_actions
	return input
