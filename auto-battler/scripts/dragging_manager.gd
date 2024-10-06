extends Node

var active_team = 0

func is_active_team(team: int):
	return team == active_team
	
func validate(input: CharacterInput, team: int) -> CharacterInput:
	if not is_active_team(team):
		if not input.dragging_injected:
			input.actions = input.actions.filter(func(a): return a!="Dragging")
	return input
