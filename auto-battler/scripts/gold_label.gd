class_name GoldLabel extends Label

@export var game_resource: GameResource

func _ready():
	game_resource.gold_changed.connect(_update_gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update_gold(new_value: int, old_value: int):
	text = str(new_value)
