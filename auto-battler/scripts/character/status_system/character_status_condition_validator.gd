class_name CharacterStatusSystem extends Node

var character_status_dictionary: Dictionary = {}

func _ready():
	for child in get_children():
		if child is CharacterStatus:
			character_status_dictionary[child.name] = child

func update(input: CharacterInput):
	if input.take_damage:
		character_status_dictionary["Health"].current_value -= 15

func validate(input: CharacterInput, states: Dictionary) -> CharacterInput:
	var filtered_actions: Array[String] = []
	for action in input.actions:
		if action not in states:
			filtered_actions.append(action)
			continue
		var state = states[action]
		var conditions = state.status_conditions
		var valid = true
		for condition in conditions:
			var status = character_status_dictionary[condition.status]
			valid = valid and condition.is_valid(status)
		if valid:
			filtered_actions.append(action)
	input.actions = filtered_actions
	return input
