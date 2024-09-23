extends Node2D
@onready var building_placement_manager: BuildingPlacementManager = $BuildingPlacementManager


# Called when the node enters the scene tree for the first time.
func _ready():
	CharacterSpawningManager.target = self


func _on_barracks_pressed():
	building_placement_manager.start_placement("Barracks")
