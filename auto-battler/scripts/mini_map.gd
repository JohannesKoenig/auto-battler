class_name MiniMap extends MarginContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var camera_rect = $MarginContainer/CameraRect
@onready var boundary_rect = $MarginContainer/BoundaryRect

@onready var panel = $Panel

@export var tile_map: WorldMap
var _image: Image
var _camera_rect_image: Image
var _boundary_rect_image: Image

var _min_x = 0
var _min_y = 0

var camera: Camera2D

var color_map = {
	1: Color.from_string("#5b6ee1", Color.BLUE),
	2: Color.from_string("#6abe30", Color.GREEN),
	3: Color.from_string("#d9a066", Color.SADDLE_BROWN),
	4: Color.from_string("#eec39a", Color.BURLYWOOD)
}

func _ready():
	camera = get_viewport().get_camera_2d()
	var used_rect = tile_map.get_used_rect()
	var width = used_rect.size.x
	var height = used_rect.size.y
	size = Vector2(width, height)
	panel.size = size + Vector2(4, 4)
	_image = Image.create_empty(width, height, false, Image.FORMAT_RGBA8)
	_camera_rect_image = Image.create_empty(width, height, false, Image.FORMAT_RGBA8)
	_boundary_rect_image = Image.create_empty(width, height, false, Image.FORMAT_RGBA8)
	for cell in tile_map.get_used_cells():
		_min_x = min(_min_x, cell.x)
		_min_y = min(_min_y, cell.y)
	_min_x = abs(_min_x)
	_min_y = abs(_min_y)
	for cell in tile_map.get_used_cells():
		_image.set_pixel(cell.x + _min_x, cell.y + _min_y, color_map[tile_map.get_cell_source_id(cell)])
	texture_rect.texture = ImageTexture.create_from_image(_image)
	camera_rect.texture = ImageTexture.create_from_image(_camera_rect_image)
	boundary_rect.texture = ImageTexture.create_from_image(_boundary_rect_image)

func _process(delta):
	_draw_camera_rect()
	

func _draw_camera_rect():
	var position = camera.position + camera.offset
	var map_position = Boundary.world_to_map(position)
	_camera_rect_image.fill(Color.from_string("#00000000", Color.WHITE))
	_camera_rect_image.set_pixel(map_position.x + _min_x, map_position.y + _min_y, Color.WHITE)
	camera_rect.texture.update(_camera_rect_image)
	
	_boundary_rect_image.fill(Color.from_string("#00000000", Color.WHITE))
	for cell in tile_map.boundary_0.world_map.get_used_cells():
		_boundary_rect_image.set_pixel(cell.x + _min_x, cell.y + _min_y, Color.BLUE)
	boundary_rect.texture.update(_boundary_rect_image)
