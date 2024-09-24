class_name CharacterModel extends Node

@export var character: Character

@onready var physics: CharacterBody2D = $Physics
@onready var state_machine: StateMachine = $StateMachine
@onready var character_status_system: CharacterStatusSystem = $CharacterStatusSystem
@onready var rig: Node2D = $Physics/Rig
@onready var character_attack_system = $CharacterAttackSystem
@onready var cool_down_validator = $CoolDownValidator
@onready var character_buff_system = $CharacterBuffSystem
@onready var navigation_agent_2d = $Physics/NavigationAgent2D


signal death

func _ready():
	state_machine.accept_character(character)
	character_status_system.accept_character(character)

func update(input: CharacterInput):
	input = character_status_system.validate(input, state_machine.states)
	input = character_attack_system.validate(input, state_machine.states)
	input = cool_down_validator.validate(input, state_machine.states)
	input = state_machine.validate(input)
	input = DraggingManager.validate(input, character.team)
	input.sort(state_machine.states)
	
	state_machine.update(input)
	if not state_machine.states[state_machine.current_state].freeze_physics:
		physics.move_and_slide()

	if state_machine.current_state == "Death":
		death.emit()
