class_name TestCharacterInputGenerator extends CharacterInputGenerator


func get_input() -> CharacterInput:
	var character_input = CharacterInput.new()
	character_input.actions.append("Idle")
	character_input.actions.append("Dead")
	if pick_up_area.dragging:
		character_input.actions.append("Dragging")
		character_input.dragging_target = pick_up_area.dragging_target
	return character_input
