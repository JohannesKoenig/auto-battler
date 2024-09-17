class_name StateMachineInput extends Node

var actions: Array[String] = []

var _states: Dictionary

func sort(states: Dictionary):
	_states = states
	actions.sort_custom(_sort_actions)

func _sort_actions(a: String, b: String) -> bool:
	var a_state: State = _states[a]
	var b_state: State = _states[b]
	if a_state.priority < b_state.priority:
		return true
	return false
