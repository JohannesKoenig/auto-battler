extends Node

var units: Dictionary = {
	0: {},
	1: {}
}

func register_unit(unit: Character, team: int):
	units[team][unit.name] = unit

func deregister_unit(unit: Character, team: int):
	units[team].erase(unit.name)

func get_units(team: int):
	return units[team]
