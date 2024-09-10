class_name CharacterModel extends Node

@onready var physics: CharacterBody2D = $Physics
@onready var state_machine: StateMachine = $StateMachine
@onready var character_status_system: CharacterStatusSystem = $CharacterStatusSystem
@onready var rig: Node2D = $Physics/Rig
@onready var character_attack_system = $CharacterAttackSystem
@onready var pick_up_area = $Physics/PickUpArea



signal death

func update(input: CharacterInput):
	character_status_system.update(input)
	input = character_status_system.validate(input, state_machine.states)
	input = character_attack_system.validate(input, state_machine.states)
	input = pick_up_area.validate_input(input)
	state_machine.update(input)
	physics.move_and_slide()
	
	if state_machine.current_state == "Death":
		death.emit()
