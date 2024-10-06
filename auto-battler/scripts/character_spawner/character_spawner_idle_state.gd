class_name CharacterSpawnerIdleState extends State

func update(input: StateMachineInput, delta: float):
	_actor.velocity = Vector2.ZERO

func on_enter():
	_actor.velocity = Vector2.ZERO
	super()
