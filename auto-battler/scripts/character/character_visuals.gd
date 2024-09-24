class_name CharacterVisuals extends Node2D

@export var character: Character
@export var ghost_texture: Texture

var _model: CharacterModel
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $GUI/HealthBar
@onready var buff_bar: BuffBar = $GUI/BuffBar
@onready var rig = $Rig
@onready var team_marker = $Rig/TeamMarker
@onready var text_rig = $GUI/TextRig
@onready var gui = $GUI


func _ready():
	if character.team == 0:
		team_marker.modulate = Color.CORNFLOWER_BLUE
	elif character.team == 1:
		team_marker.modulate = Color.TOMATO

func accept_model(model: CharacterModel):
	_model = model
	var health: HealthStatus = _model.character_status_system.character_status_dictionary["Health"]
	health.damaged.connect(_spawn_damage_popup)
	buff_bar.accept_buff_system(model.character_buff_system)

func _process(_delta):
	if _model.state_machine.current_state == "Dead":
		gui.visible = false
		team_marker.visible = false
	var current_state = _model.state_machine.current_state
	rig.scale = _model.rig.scale
	animation_player.play(current_state)
	var health = _model.character_status_system.character_status_dictionary["Health"]
	health_bar.max_value = health.max_value
	health_bar.min_value = health.min_value
	health_bar.value = health.current_value
	if health.current_value == health.max_value:
		health_bar.visible = false
	else:
		health_bar.visible = true

func _spawn_damage_popup(damage: int):
	if damage == 0:
		return
	var instance = PopUpText.get_damage(damage)
	text_rig.add_child(instance)

func get_ghost_texture() -> Texture:
	return ghost_texture
