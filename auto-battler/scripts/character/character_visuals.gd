class_name CharacterVisuals extends Node2D

var _model: CharacterModel
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $HealthBar


func accept_model(model: CharacterModel):
	_model = model

func _process(_delta):
	var current_state = _model.state_machine.current_state
	print(current_state)
	animation_player.play(current_state)
	var health = _model.character_status_condition_validator.character_status_dictionary["Health"]
	health_bar.max_value = health.max_value
	health_bar.min_value = health.min_value
	health_bar.value = health.current_value
