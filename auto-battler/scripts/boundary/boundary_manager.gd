extends Node

var boundaries = {}

func add_boundary(team: int, boundary: Boundary):
	boundaries[team] = boundary

func get_boundary(team: int) -> Boundary:
	return boundaries[team]
