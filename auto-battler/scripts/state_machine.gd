class_name StateMachine extends Node

var current_state: String
var states: Dictionary = {}
@export var starting_state: String
@export var actor: CharacterBody2D
@export var rig: Node2D
@export var hurtbox: Hurtbox
var character: Character

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.accept_actor(actor)
			child.accept_rig(rig)
			child.accept_hurtbox(hurtbox)
			
	current_state = starting_state

func accept_character(character: Character):
	self.character = character
	for state in states.keys():
		states[state].accept_character(character)

func update(input: StateMachineInput):
	var current_state_node = states[current_state]
	var next_state = current_state_node.transition(input)
	if next_state != current_state:
		switch_states(next_state)
	current_state_node.update(input)


func switch_states(next_state: String):
	var current_state_node = states[current_state]
	current_state_node.on_exit()
	var next_state_node = states[next_state]
	next_state_node.on_enter()
	current_state = next_state
