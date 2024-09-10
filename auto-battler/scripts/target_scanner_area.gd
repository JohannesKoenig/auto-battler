class_name TargetScannerArea extends Area2D

var target: Vector2
var has_target: bool = false
@export var character: Character

func _process(_delta):
	if not _has_overlapping_enemies():
		has_target = false
		return
	var closest_distance: float = INF
	for enemy in _get_overlapping_enemies():
		var distance = (character.global_position - enemy.global_position).length()
		if distance < closest_distance:
			closest_distance = distance
			target = enemy.global_position
			has_target = true

func _has_overlapping_enemies() -> bool:
	for area in get_overlapping_areas():
		if area is Hurtbox:
			var other_character = area.character
			if other_character.team != character.team:
				return true
	return false

func _get_overlapping_enemies() -> Array[Character]:
	var characters: Array[Character] = []
	for area in get_overlapping_areas():
		if area is Hurtbox:
			var other_character = area.character
			if other_character.team != character.team:
				characters.append(other_character)
	return characters
