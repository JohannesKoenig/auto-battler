class_name CharacterSpawnerInputGenerator extends CharacterInputGenerator


func get_input() -> CharacterInput:
	var input = CharacterInput.new()
	input.actions.append("Spawn")
	input.actions.append("Idle")
	input.actions.append("Dead")
	return input
	
