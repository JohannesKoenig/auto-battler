class_name CharacterVisuals extends Node2D

var _model: CharacterModel
@onready var animation_player = $AnimationPlayer


func accept_model(model: CharacterModel):
	_model = model

func _process(_delta):
	var current_state = _model.state_machine.current_state
	print(current_state)
	animation_player.play(current_state)
