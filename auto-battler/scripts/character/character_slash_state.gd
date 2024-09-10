class_name CharacterSlashState extends CharacterAttackState

var duration: float = 1
@onready var hitbox = $Rig/Hitbox
@onready var rig = $Rig



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
	if input is not CharacterInput:
		return
	var target = input.target
	rig.look_at(target)
	if input.has_target:
		if _is_left(target):
			_rig.scale = Vector2(-1, 1)
		else:
			_rig.scale = Vector2(1, 1)
	_actor.velocity = Vector2.ZERO


func on_enter():	
	hitbox.hit_id = Time.get_unix_time_from_system()
	hitbox.active = true
	super()
	
func on_exit():
	hitbox.active = false
	super()
