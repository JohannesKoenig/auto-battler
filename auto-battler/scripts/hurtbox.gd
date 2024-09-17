class_name Hurtbox extends Area2D

@export var character: Character

signal damaged(value: int)
var registered_hit: bool = false

var hit_registry: Dictionary = {}

func _process(_delta):
	for area in get_overlapping_areas():
		if area is Hitbox and area.character.team != character.team and area.active:
			if area in hit_registry:
				var last_id = hit_registry[area]
				if last_id == area.hit_id:
					continue
			_register_hit(area)
			damaged.emit(area.damage)
			for buff in area.character_buffs:
				character.character_model.character_buff_system.add_buff(buff)
			
		
func _register_hit(hitbox: Hitbox):
	hit_registry[hitbox] = hitbox.hit_id
	registered_hit = true
