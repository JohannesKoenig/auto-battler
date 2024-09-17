class_name CharacterIdleState extends State


func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
