class_name AiTask extends Node

var enter_timestamp: float
var active: bool = false
@export var cool_down: float = 0.0
@export var priority: int = 10

signal entered

func transition(input: AiInput) -> String:
	if len(input.actions) > 0:
		return input.actions[0]
	return name

func on_exit(input: AiInput):
	active = false
	pass

func on_enter(input: AiInput):
	entered.emit()
	active = true
	_mark_enter()
	pass

func update(input: AiInput):
	pass

func _mark_enter():
	enter_timestamp = Time.get_unix_time_from_system()

func _has_passed(time: float):
	return time < Time.get_unix_time_from_system() - enter_timestamp

func on_cool_down() -> bool:
	return not _has_passed(cool_down)

func is_valid() -> bool:
	return true
