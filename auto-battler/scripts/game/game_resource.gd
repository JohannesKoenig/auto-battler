class_name GameResource extends Resource

var gold: int = 0:
	set(value):
		var old_value = gold
		gold = value
		gold_changed.emit(value, old_value)

signal gold_changed(new_value: int, old_value: int)
