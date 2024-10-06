@tool
class_name Character extends Node2D

@onready var character_model: CharacterModel = $CharacterModel
@onready var character_visuals = $CharacterVisuals

@export var unit_name: String
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
	UnitManager.register_unit(self, team)

func update(input: CharacterInput, delta: float):
	character_model.update(input, delta)
	
func _process(delta):
	if Engine.is_editor_hint():
		return
	var input = character_input.get_input()
	update(input, delta)
	input.queue_free()
	transform = character_model.physics.transform

func _on_death():
	UnitManager.deregister_unit(self, team)
	queue_free()

func _get_configuration_warnings():
	var warnings = []

	if character_input == null:
		warnings.append("Please add a CharacterInputGenerator.")

	# Returning an empty array means "no warning".
	return warnings

func get_ghost_texture() -> Texture:
	return character_visuals.get_ghost_texture()
