class_name CharacterVisuals extends Node2D

var _model: CharacterModel
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $HealthBar
@onready var buff_bar: BuffBar = $BuffBar
@onready var rig = $Rig
@onready var team_marker = $TeamMarker
@onready var text_rig = $TextRig


func accept_model(model: CharacterModel):
	_model = model
	var health: HealthStatus = _model.character_status_system.character_status_dictionary["Health"]
	health.damaged.connect(_spawn_damage_popup)
	buff_bar.accept_buff_system(model.character_buff_system)

func _process(_delta):
	if _model.state_machine.current_state == "Dead":
		health_bar.visible = false
		buff_bar.visible = false
		team_marker.visible = false
	var current_state = _model.state_machine.current_state
	rig.scale = _model.rig.scale
	animation_player.play(current_state)
	var health = _model.character_status_system.character_status_dictionary["Health"]
	health_bar.max_value = health.max_value
	health_bar.min_value = health.min_value
	health_bar.value = health.current_value

func _spawn_damage_popup(damage: int):
	if damage == 0:
		return
	var instance = PopUpText.get_damage(damage)
	text_rig.add_child(instance)
