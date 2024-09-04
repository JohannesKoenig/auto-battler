class_name NotFullCondition extends StatusCondition

func is_valid(status: CharacterStatus) -> bool:
	return status.current_value < status.max_value 
