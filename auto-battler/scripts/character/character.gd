class_name Character extends Node2D

@onready var character_model = $CharacterModel
@onready var character_visuals = $CharacterVisuals
@onready var pick_up_area = $PickUpArea

@export var character_input: CharacterInputGenerator

func _ready():
	character_visuals.accept_model(character_model)
	character_model.physics.global_position = global_position

func update(input: CharacterInput):
	character_model.update(input)
	
func _process(_delta):
	var input = character_input.get_input()
	update(input)
	input.queue_free()
	transform = character_model.physics.transform
