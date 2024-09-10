@tool
class_name Character extends Node2D

@onready var character_model = $CharacterModel
@onready var character_visuals = $CharacterVisuals

@export var character_input: CharacterInputGenerator:
	set(value):
		character_input = value
		update_configuration_warnings()
@export var team: int


func _ready():
	if Engine.is_editor_hint():
		return
	character_visuals.accept_model(character_model)
	character_model.physics.global_position = global_position

func update(input: CharacterInput):
	character_model.update(input)
	
func _process(_delta):
	if Engine.is_editor_hint():
		return
	var input = character_input.get_input()
	update(input)
	input.queue_free()
	transform = character_model.physics.transform

func _on_death():
	queue_free()

func _get_configuration_warnings():
	var warnings = []

	if character_input == null:
		warnings.append("Please add a CharacterInputGenerator.")

	# Returning an empty array means "no warning".
	return warnings
