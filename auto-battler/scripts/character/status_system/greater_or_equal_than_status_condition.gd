class_name GreaterOrEqualThanStatusCondition extends StatusCondition

@export var cost: int

func is_valid(status: CharacterStatus) -> bool:
	return status.current_value >= cost
