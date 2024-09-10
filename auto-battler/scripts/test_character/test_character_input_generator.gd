class_name TestCharacterInputGenerator extends CharacterInputGenerator


func get_input() -> CharacterInput:
	var character_input = CharacterInput.new()
	character_input.actions.append("Idle")
	character_input.actions.append("Dead")
	if Input.is_action_just_pressed("PickUp"):
		character_input.actions.append("PickUp")
	if Input.is_action_pressed("PickUp"):
		character_input.actions.append("Dragging")
	if Input.is_action_just_released("PickUp"):
		character_input.actions.append("Drop")

	#if pick_up_area.dragging:
	#	character_input.actions.append("Dragging")
	#	character_input.dragging_target = pick_up_area.dragging_target
	if target_scanner_area.has_target:
		character_input.actions.append("Follow")
		character_input.actions.append("Slash")
		character_input.target = target_scanner_area.target
		character_input.has_target = true
	if hurtbox.registered_hit:
		character_input.take_damage = true
		hurtbox.registered_hit = false
	return character_input
