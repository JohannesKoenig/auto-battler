class_name Hitbox extends Area2D

@export var character: Character
@export var damage: float = 15
@export var character_buffs: Array[CharacterBuff] = []
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var active: bool = false
var hit_id: float = 0

func _process(delta):
	collision_shape_2d.disabled = !active
