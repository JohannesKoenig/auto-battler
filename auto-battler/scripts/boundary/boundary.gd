class_name Boundary extends Node2D

@export var team: int = 0
@onready var world_map: TileMapLayer = $WorldMap
@onready var tile_map_dual: TileMapDual = $TileMapDual

var full_tile_coords: Vector2i = Vector2i(2, 1)
var blocked_tile_coords: Vector2i = Vector2i(0, 3)
static var TILE_SIZE: int = 16

func _ready():
	register()
	if team == 0:
		modulate = Color.ROYAL_BLUE
	elif team == 1:
		modulate = Color.TOMATO
	world_map.visible = false

func register():
	BoundaryManager.add_boundary(team, self)

func mark(coords: Vector2i):
	tile_map_dual.fill_tile(coords)

func unmark(coords: Vector2i):
	tile_map_dual.erase_tile(coords)

func block(coords: Vector2i):
	world_map.set_cell(coords, 1, blocked_tile_coords)

func is_marked(coords: Vector2i) -> bool:
	var atlas_coords = world_map.get_cell_atlas_coords(coords)
	return atlas_coords == full_tile_coords

func is_blocked(coords: Vector2i) -> bool:
	var atlas_coords = world_map.get_cell_atlas_coords(coords)
	return atlas_coords == blocked_tile_coords

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

func get_free_neighbours(coords: Vector2i, distance: int = 1) -> Array[Vector2i]:
	var free_neighbours: Array[Vector2i] = []
	var surrounding_cells = []
	if distance == 0:
		surrounding_cells = coords
	elif distance == 1:
		surrounding_cells = world_map.get_surrounding_cells(coords)
	elif distance > 1:
		for i in [-1 * distance, distance]:
			for j in range(-1 * distance, distance + 1):
				surrounding_cells.append(coords + Vector2i(i, j))
				surrounding_cells.append(coords + Vector2i(j, i))
	for cell in surrounding_cells: 
		if not is_marked(cell) and not is_blocked(cell):
			free_neighbours.append(cell)
	return free_neighbours

func get_marked_neighbours(coords: Vector2i, distance: int = 1) -> Array[Vector2i]:
	var marked_neighbours: Array[Vector2i] = []
	var surrounding_cells = []
	if distance == 0:
		surrounding_cells.append(coords)
	elif distance == 1:
		surrounding_cells = world_map.get_surrounding_cells(coords)
	elif distance > 1:
		for i in [-1 * distance, distance]:
			for j in range(-1 * distance, distance + 1):
				surrounding_cells.append(coords + Vector2i(i, j))
				surrounding_cells.append(coords + Vector2i(j, i))
	for cell in surrounding_cells: 
		if is_marked(cell):
			marked_neighbours.append(cell)
	return marked_neighbours
