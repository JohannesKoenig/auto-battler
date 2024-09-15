class_name CharacterShootState extends CharacterAttackState

var duration: float = 10
var spawn_delay: float = 0.5
@export var projectile: PackedScene
@onready var projectile_emitter = $ProjectileEmitter
var shot: bool = false


func transition(input: StateMachineInput) -> String:
	if _has_passed(duration):
		return "Idle"
	if "Dead" in input.actions:
		return "Dead"
	if "Dragging" in input.actions:
		return "Dragging"
	if name in input.actions:
		return name
	return name

func update(input: StateMachineInput):
	if _has_passed(spawn_delay) and input is CharacterInput and not shot:
		var projectile_instance = projectile.instantiate()
		projectile_instance.global_position = projectile_emitter.global_position
		projectile_instance.character = _character
		get_tree().root.add_child(projectile_instance)
		projectile_instance.shoot(input.target)
		shot = true
	_actor.velocity = Vector2.ZERO

func on_enter():
	shot = false
	super()
	
func on_exit():
	super()
