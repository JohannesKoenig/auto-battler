class_name CharacterAttackSystem extends Node


func validate(input: CharacterInput, states: Dictionary) -> CharacterInput:
	var filtered_actions: Array[String] = []
	for action in input.actions:
		if action not in states:
			filtered_actions.append(action)
			continue
		var state = states[action]
		if state is not CharacterAttackState:
			filtered_actions.append(action)
		else:
			var distance = (input.target - state._actor.global_position).length()
			if state.min_distance < distance and distance < state.max_distance:
				filtered_actions.append(action)
	input.actions = filtered_actions
	return input
