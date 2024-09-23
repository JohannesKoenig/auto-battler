class_name CharacterSpawnerIdleState extends State

func update(input: StateMachineInput):
	_actor.velocity = Vector2.ZERO

func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
