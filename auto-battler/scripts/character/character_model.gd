class_name CharacterModel extends Node

@onready var physics: CharacterBody2D = $Physics
@onready var state_machine: StateMachine = $StateMachine
@onready var character_status_condition_validator: CharacterStatusConditionValidator = $CharacterStatusConditionValidator


func update(input: CharacterInput):
	input = character_status_condition_validator.validate(input, state_machine.states)
	state_machine.update(input)
