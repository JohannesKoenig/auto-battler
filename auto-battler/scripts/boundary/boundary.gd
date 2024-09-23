class_name Boundary extends Node2D

@export var team: int = 0
@onready var world_map: TileMapLayer = $WorldMap
@onready var tile_map_dual: TileMapDual = $TileMapDual

var full_tile_coords: Vector2i = Vector2i(2, 1)
static var TILE_SIZE: int = 16

func _ready():
	BoundaryManager.add_boundary(team, self)
	if team == 0:
		modulate = Color.ROYAL_BLUE
	elif team == 1:
		modulate = Color.TOMATO

func mark(coords: Vector2i):
	tile_map_dual.fill_tile(coords)

func unmark(coords: Vector2i):
	tile_map_dual.erase_tile(coords)

func is_marked(coords: Vector2i) -> bool:
	var atlas_coords = world_map.get_cell_atlas_coords(coords)
	return atlas_coords == full_tile_coords

static func world_to_map(coords: Vector2) -> Vector2i:
	var x = coords.x / TILE_SIZE
	var y = coords.y / TILE_SIZE
	if x < 0:
		x -= 1
	if y < 0:
		y -= 1
	return Vector2i(x, y)

static func map_to_world(coords: Vector2i) -> Vector2:
	var x_offset = 0.5
	var y_offset = 0.5
	return Vector2(
			(float(coords.x) + x_offset) * float(TILE_SIZE),
			(float(coords.y) + y_offset) * float(TILE_SIZE)
		)

func get_free_neighbours(coords: Vector2i) -> Array[Vector2i]:
	var free_neighbours: Array[Vector2i] = []
	var surrounding_cells = world_map.get_surrounding_cells(coords)
	for cell in surrounding_cells: 
		var source_id = world_map.get_cell_source_id(cell)
		var atlas_coords = world_map.get_cell_atlas_coords(cell)
		if atlas_coords != full_tile_coords:
			free_neighbours.append(cell)
	return free_neighbours
