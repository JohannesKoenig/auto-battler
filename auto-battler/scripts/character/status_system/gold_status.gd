class_name GoldStatus extends CharacterStatus

var game_resource: GameResource

func _ready():
	pass

func accept_character(character: Character):
	_character = character
	if _character.team == 0:
		game_resource = load("res://resources/game/game_resource_team_0.tres")
	elif _character.team == 1:
		game_resource = load("res://resources/game/game_resource_team_1.tres")
	
	max_value = 10000000
	min_value = 0
	current_value = game_resource.gold
	game_resource.gold_changed.connect(_update_gold)

func _update_gold(new_value: int, old_value: int):
	current_value = new_value
