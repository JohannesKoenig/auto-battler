class_name EmptyCondition extends StatusCondition

func is_valid(status: CharacterStatus) -> bool:
	return status.current_value <= status.min_value 
