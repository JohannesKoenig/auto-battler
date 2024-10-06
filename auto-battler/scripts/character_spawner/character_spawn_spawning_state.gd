class_name CharacterSpawnerSpawningState extends State

@export var character_template: PackedScene
@export var max_spawn: int = 4
@export var duration: float = 1
@export var spawn_delay: float = 0.5
@export var spawn_radius: float = 20
@export var cost: int

@onready var spawn_target: Area2D = $Rig/SpawnTarget
@onready var rig = $Rig

var game_resource: GameResource

var spawn_point: Vector2
var has_spawn_point: bool = false
var spawned: bool = false

var nr_of_characters: int = 0:
	set(value):
		nr_of_characters = value
		nr_of_character_changed.emit(value)

signal nr_of_character_changed(value: int)

func accept_character(character: Character):
	_character = character
	if _character.team == 0:
		game_resource = load("res://resources/game/game_resource_team_0.tres")
	elif _character.team == 1:
		game_resource = load("res://resources/game/game_resource_team_1.tres")

func transition(input: StateMachineInput) -> String:
	if _has_passed(duration):
		return "Idle"
	return name

func update(input: StateMachineInput, delta: float):
	if _has_passed(spawn_delay) and not spawned:
		_spawn_character()
		spawned = true
	_actor.velocity = Vector2.ZERO

func on_enter():
	spawned = false
	_actor.velocity = Vector2.ZERO
	super()

func _physics_process(delta):
	if not _can_spawn_at(spawn_point) or not has_spawn_point:
		spawn_point = _get_random_spawn_point()
		has_spawn_point = true

func _spawn_character():
	if nr_of_characters < max_spawn and game_resource.gold >= cost:
		var character = character_template.instantiate()
		character.global_position = spawn_point
		character.team = _character.team
		nr_of_characters += 1
		CharacterSpawningManager.spawn(character)
		character.character_model.state_machine.states["Dead"].entered.connect(_on_character_dead)
		has_spawn_point = false
		game_resource.gold -= cost
	
func _on_character_dead():
	nr_of_characters -= 1

func is_valid() -> bool:
	return nr_of_characters < max_spawn

func _get_random_spawn_point() -> Vector2:
	var vector = Vector2(randf_range(-1,1), randf_range(-1, 1))
	if vector == Vector2.ZERO:
		vector = Vector2.LEFT
	var pos = vector.normalized() * spawn_radius
	pos.y /= 2  # squeeze cirle to oval
	return pos + rig.global_position

func _can_spawn_at(position: Vector2) -> bool:
	spawn_target.global_position = position
	return not spawn_target.has_overlapping_areas()
