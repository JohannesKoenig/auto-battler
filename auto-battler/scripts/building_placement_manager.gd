class_name BuildingPlacementManager extends Node2D
@onready var ghost_texture: Sprite2D = $GhostTexture
@export var team: int
@export var world_map: WorldMap
var game_resource: GameResource

var placing:bool = false
var building: String
var ghost_map = {
	"CityHall": preload("res://assets/city_hall/city_hall_idle.png"),
	"Barracks": preload("res://assets/character_spawner/baracks/baracks.png")
}
var building_map = {
	"CityHall": preload("res://scenes/city_hall/city_hall.tscn"),
	"Barracks": preload("res://scenes/character_spawner/character_spawner.tscn")
}
var cost_map = {
	"CityHall": 0,
	"Barracks": 5	
}

var current_placement_coords: Vector2
var _boundary: Boundary

func _ready():
	_boundary = BoundaryManager.get_boundary(team)
	if team == 0:
		game_resource = load("res://resources/game/game_resource_team_0.tres")
	elif team == 1:
		game_resource = load("res://resources/game/game_resource_team_1.tres")

func _process(_delta):
	if placing:
		current_placement_coords = _get_rounded_position(
				get_viewport().get_mouse_position() + get_viewport().get_camera_2d().global_position
			)
		ghost_texture.global_position = current_placement_coords
		if (
			Input.is_action_just_pressed("PlaceBuilding") 
			and _boundary.is_marked(Boundary.world_to_map(current_placement_coords))
		):
			place(current_placement_coords, building)
		elif Input.is_action_just_pressed("CancelBuilding"):
			cancel()
	
func start_placement(building: String):
	var cost = cost_map[building]
	if game_resource.gold < cost:
		return
	var texture = ghost_map[building]
	ghost_texture.texture = texture
	placing = true
	ghost_texture.visible = true
	self.building = building

func _get_rounded_position(world_coords: Vector2):
	var map_positon = Boundary.world_to_map(world_coords)
	return Boundary.map_to_world(map_positon)

func place(coords: Vector2, building: String):
	game_resource.gold -= cost_map[building]
	var instance = building_map[building].instantiate()
	instance.team = team
	instance.global_position = coords 
	CharacterSpawningManager.spawn(instance)
	var map_coord = Boundary.world_to_map(current_placement_coords)
	#for i in range(-1, 2):
	#	for j in range(-1, 2):
	#		world_map.draw_dirt(map_coord + Vector2i(i, j))
	world_map.draw_dirt(map_coord)
	cancel()
	
func cancel():
	placing = false
	ghost_texture.texture = null
	ghost_texture.visible = false
