extends Node2D
@onready var building_placement_manager: BuildingPlacementManager = $BuildingPlacementManager
@onready var building_placement_manager_2: BuildingPlacementManager = $BuildingPlacementManager2

@onready var team_0_start = $Team_0_Start
@onready var team_1_start = $Team_1_Start
@onready var game_camera = $GameCamera


# Called when the node enters the scene tree for the first time.
func _ready():
	CharacterSpawningManager.target = self
	building_placement_manager.place(team_0_start.global_position, "CityHall")
	building_placement_manager_2.place(team_1_start.global_position, "CityHall")
	game_camera.global_position = team_0_start.global_position - game_camera.offset


func _on_barracks_pressed():
	building_placement_manager.start_placement("Barracks")
