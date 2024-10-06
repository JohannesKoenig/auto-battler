class_name State extends Node

var enter_timestamp: float
var _actor: CharacterBody2D
var _rig: Node2D
var _hurtbox: Hurtbox
var _character: Character
var _buff_system: CharacterBuffSystem
var _navigation_agent: NavigationAgent2D
var active: bool = false
@export var freeze_physics: bool = false
@export var status_conditions: Array[StatusCondition] = []
@export var cool_down: float = 0.0
@export var priority: int = 10

signal entered

static func is_idle(state_name: String) -> bool:
	return is_state("Idle").call(state_name)

static func not_is_state(state: String) -> Callable:
	return func(state_name: String): return state_name != state

static func is_state(state: String) -> Callable:
	return func(state_name: String): return state_name == state

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

func accept_navigation_agent(navigation_agent: NavigationAgent2D):
	_navigation_agent = navigation_agent

func transition(input: StateMachineInput) -> String:
	if len(input.actions) > 0:
		return input.actions[0]
	return name

func on_exit():
	active = false
	pass

func on_enter():
	entered.emit()
	active = true
	_mark_enter()
	pass

func update(input: StateMachineInput, delta: float):
	pass

func _mark_enter():
	enter_timestamp = Time.get_unix_time_from_system()

func _has_passed(time: float):
	return time < Time.get_unix_time_from_system() - enter_timestamp

func _is_left(target: Vector2) -> bool:
	return target.x < _actor.global_position.x

func on_cool_down() -> bool:
	return not _has_passed(cool_down)

func is_valid() -> bool:
	return true
