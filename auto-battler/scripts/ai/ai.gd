class_name Ai extends Node2D

@onready var ai_input_generator: AiInputGenerator = $AiInputGenerator
@onready var ai_state_machine: AiStateMachine = $AiStateMachine

@export var team: int = 1

func _ready():
	ai_input_generator.team = team

func _physics_process(delta):
	var input = ai_input_generator.get_input()
	input = ai_state_machine.validate(input)
	input.sort(ai_state_machine.states)
	ai_state_machine.update(input)
	input.queue_free()
