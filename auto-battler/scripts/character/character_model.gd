class_name CharacterModel extends Node

@export var character: Character

@onready var physics: CharacterBody2D = $Physics
@onready var state_machine: StateMachine = $StateMachine
@onready var character_status_system: CharacterStatusSystem = $CharacterStatusSystem
@onready var rig: Node2D = $Physics/Rig
@onready var character_attack_system = $CharacterAttackSystem
@onready var cool_down_validator = $CoolDownValidator
@onready var character_buff_system = $CharacterBuffSystem

signal death

func _ready():
	state_machine.accept_character(character)

func update(input: CharacterInput):
	input = character_status_system.validate(input, state_machine.states)
	input = character_attack_system.validate(input, state_machine.states)
	input = cool_down_validator.validate(input, state_machine.states)
	state_machine.update(input)
	physics.move_and_slide()
	
	if state_machine.current_state == "Death":
		death.emit()
