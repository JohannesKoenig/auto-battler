class_name AiInputGenerator extends Node2D

var team: int

func get_input() -> AiInput:
	var boundary = BoundaryManager.get_boundary(team)
	var input = AiInput.new()
	input.actions.append("Idle")
	var units = UnitManager.get_units(team)
	var idle_explorer = _get_unit(units, "Explorer")
	if idle_explorer:
		var city_hall = _get_unit(units, "CityHall")
		if city_hall:
			#print("Idle CityHall: ", city_hall)
			var explore_target = _explore_around(city_hall.position, boundary)
			if explore_target != null:
				input.actions.append("Explore")
				input.dragged_character = idle_explorer
				input.dragging_target = explore_target
		

	return input
	
func _get_unit(units: Dictionary, unit_name: String, filter: Callable = State.is_idle) -> Character:
	for value: Character in units.values():
		if (
			value.unit_name == unit_name 
			and filter.call(value.character_model.state_machine.current_state)
		):
			return value
	return null


func _explore_around(source: Vector2, boundary: Boundary):
	var source_tile_coords = Boundary.world_to_map(source)
	for i in range(0, 50):
		var free_neighbours: Array[Vector2i] = boundary.get_free_neighbours(source_tile_coords, i)
		if len(free_neighbours) > 0:
			var target_cell = free_neighbours.pick_random()
			for j in range(0, 50):
				var marked_neighbours: Array[Vector2i] = boundary.get_marked_neighbours(target_cell, j)
				if len(marked_neighbours) > 0:
					return Boundary.map_to_world(marked_neighbours.pick_random())
			return 
	return null
