class_name CharacterModel extends Node

@onready var physics: CharacterBody2D = $Physics
@onready var state_machine: StateMachine = $StateMachine



func update(input: CharacterInput):
	state_machine.update(input)
