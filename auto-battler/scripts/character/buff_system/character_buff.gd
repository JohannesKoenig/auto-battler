class_name CharacterBuff extends Node

var start_time: float
@export var texture: Texture
@export var duration: float
var active = true

func is_active() -> bool:
	return active

func activate():
	start_time = Time.get_unix_time_from_system()
	active = true

func deactivate():
	active = false

func _process(delta):
	if is_active() and duration < Time.get_unix_time_from_system() - start_time:
		deactivate()
