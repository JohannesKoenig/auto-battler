class_name State extends Node

var enter_timestamp: float
var _actor: CharacterBody2D
var _rig: Node2D
@export var status_conditions: Array[StatusCondition] = []

func accept_actor(actor: CharacterBody2D):
	_actor = actor

func accept_rig(rig: Node2D):
	_rig = rig

func transition(input: StateMachineInput) -> String:
	return name

func on_exit():
	pass

func on_enter():
	_mark_enter()
	pass

func update(input: StateMachineInput):
	pass

func _mark_enter():
	enter_timestamp = Time.get_unix_time_from_system()

func _has_passed(time: float):
	return time < Time.get_unix_time_from_system() - enter_timestamp

func _is_left(target: Vector2) -> bool:
	return target.x < _actor.global_position.x
