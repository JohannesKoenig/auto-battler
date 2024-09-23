class_name GoldGenerator extends Node

@export var game_resource: GameResource

var tween: Tween

func _ready():
	tween = create_tween()
	tween.tween_callback(_add_gold).set_delay(2)
	tween.set_loops()
	
func _add_gold():
	game_resource.gold += 1
