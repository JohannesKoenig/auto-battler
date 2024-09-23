class_name PipDisplay extends HBoxContainer

@export var spawn_state: CharacterSpawnerSpawningState
var pip_template = preload("res://scenes/pip.tscn")

var _nr_of_pips: int
var pips = [] 

func _ready():
	update_pips(spawn_state.max_spawn)
	spawn_state.nr_of_character_changed.connect(update_active)

func update_pips(nr_of_pips: int):
	_nr_of_pips = nr_of_pips
	pips = []
	for i in range(nr_of_pips):
		var pip = pip_template.instantiate()
		add_child(pip)
		pips.append(pip)

func update_active(active_pips: int):
	for i in range(active_pips):
		pips[i].activate()
	for i in range(active_pips, _nr_of_pips):
		pips[i].deactivate()
