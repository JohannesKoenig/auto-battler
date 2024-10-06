class_name SpiderCharacterInputGenerator extends CharacterInputGenerator


func get_input() -> CharacterInput:
	var character_input = CharacterInput.new()
	character_input.actions.append("Idle")
	character_input.actions.append("Dead")
	if pick_up_area.dragging:
		character_input.actions.append("Dragging")
		character_input.dragging_injected = pick_up_area.injected
		character_input.dragging_target = pick_up_area.dragging_target
	if target_scanner_area.has_target:
		character_input.actions.append("Follow")
		character_input.actions.append("Slash")
		character_input.actions.append("Shoot")
		character_input.target = target_scanner_area.target
		character_input.has_target = true

	return character_input
