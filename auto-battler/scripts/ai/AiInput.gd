class_name AiInput extends Node

var actions: Array[String] = []
var dragging_target: Vector2
var dragged_character: Character

var _states: Dictionary

func sort(states: Dictionary):
	_states = states
	actions.sort_custom(_sort_actions)

func _sort_actions(a: String, b: String) -> bool:
	var a_state: AiTask = _states[a]
	var b_state: AiTask = _states[b]
	if a_state.priority < b_state.priority:
		return true
	return false
