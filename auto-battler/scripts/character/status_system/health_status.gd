class_name HealthStatus extends CharacterStatus

func _ready():
	current_value = max_value
	pass

func take_damage(value: int):
	current_value -= value
