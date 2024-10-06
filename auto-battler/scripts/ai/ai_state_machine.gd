class_name AiStateMachine extends Node

var current_state: String
var states: Dictionary = {}
@export var starting_state: String

@export var tick: float = 1.0


func _ready():
	for child in get_children():
		if child is AiTask:
			states[child.name] = child
			
	current_state = starting_state

func update(input: AiInput):
	var current_state_node = states[current_state]
	var next_state = current_state_node.transition(input)
	if next_state != current_state:
		switch_states(next_state, input)
	current_state_node.update(input)

func switch_states(next_state: String, input: AiInput):
	var current_state_node = states[current_state]
	current_state_node.on_exit(input)
	var next_state_node = states[next_state]
	next_state_node.on_enter(input)
	current_state = next_state

func validate(input: AiInput) -> AiInput:
	var filtered_actions: Array[String] = []
	for action in input.actions:
		var state_node = states[action]
		if state_node.is_valid():
			filtered_actions.append(action)
	input.actions = filtered_actions
	return input
