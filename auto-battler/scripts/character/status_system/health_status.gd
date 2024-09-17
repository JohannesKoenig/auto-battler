class_name HealthStatus extends CharacterStatus

signal damaged(damage: int)

func _ready():
	current_value = max_value
	pass

func take_damage(value: int):
	current_value -= value
	damaged.emit(value)
	
