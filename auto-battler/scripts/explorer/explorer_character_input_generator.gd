class_name ExplorerCharacterInputGenerator extends CharacterInputGenerator


func get_input() -> CharacterInput:
	var character_input = CharacterInput.new()
	character_input.actions.append("Idle")
	character_input.actions.append("Dead")
	character_input.actions.append("Seek")
	if pick_up_area.dragging:
		character_input.actions.append("Dragging")
		character_input.dragging_injected = pick_up_area.injected
		character_input.dragging_target = pick_up_area.dragging_target

	return character_input
