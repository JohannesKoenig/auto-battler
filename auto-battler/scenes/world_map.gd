class_name WorldMap extends TileMapLayer

@onready var water = $Water
@onready var water_tile_map_dual = $WaterTileMapDual
@onready var sand = $Sand
@onready var sand_tile_map_dual = $SandTileMapDual
@onready var dirt = $Dirt
@onready var dirt_tile_map_dual = $DirtTileMapDual
@onready var grass = $Grass
@onready var grass_tile_map_dual = $GrassTileMapDual
@onready var boundary_0 = $Boundary0
@onready var boundary_1 = $Boundary1

var source_id_map = {}

var full_tile_coords = Vector2i(2, 1)

func _ready():
	source_id_map[1] = water_tile_map_dual
	source_id_map[2] = grass_tile_map_dual
	source_id_map[3] = dirt_tile_map_dual
	source_id_map[4] = sand_tile_map_dual
	update()

func update():
	for cell in get_used_cells():
		var source_id = get_cell_source_id(cell)
		update_cell(cell, source_id)

func update_cell(coords: Vector2i, source_id: int):
	var map: TileMapDual = source_id_map[source_id]
	map.fill_tile(coords)
	if source_id == 1:
		boundary_0.block(coords)
		boundary_1.block(coords)

func draw_dirt(coords: Vector2i):
	var previous_content = get_cell_source_id(coords)
	var map: TileMapDual = source_id_map[previous_content]
	map.erase_tile(coords)
	set_cell(coords, 3, full_tile_coords)
	update_cell(coords, 3)
