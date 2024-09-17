class_name State extends Node

var enter_timestamp: float
var _actor: CharacterBody2D
var _rig: Node2D
var _hurtbox: Hurtbox
var _character: Character
var _buff_system: CharacterBuffSystem
@export var status_conditions: Array[StatusCondition] = []
@export var cool_down: float = 0.0
@export var priority: int = 10

func accept_actor(actor: CharacterBody2D):
	_actor = actor

func accept_rig(rig: Node2D):
	_rig = rig

func accept_hurtbox(hurtbox: Hurtbox):
	_hurtbox = hurtbox

func accept_character(character: Character):
	_character = character

func accept_buff_system(buff_system: CharacterBuffSystem):
	_buff_system = buff_system

func transition(input: StateMachineInput) -> String:
	if len(input.actions) > 0:
		return input.actions[0]
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

func on_cool_down() -> bool:
	return not _has_passed(cool_down)
