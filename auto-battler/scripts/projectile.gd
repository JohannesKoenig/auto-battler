class_name Projectile extends CharacterBody2D

@export var on_hit_effect: PackedScene
@export var speed: float = 10
@export var time_to_live: float = 2
var target: Vector2
var active: bool = false
var character: Character
var _spawn_time: float
var _direction: Vector2

@onready var animation_player = $AnimationPlayer
@onready var hitbox = $Hitbox
@onready var sprite_2d = $Sprite2D
@onready var drop_shadow = $DropShadow


func _ready():
	hitbox.character = character

func on_hit():
	if on_hit_effect:
		var instance = on_hit_effect.instantiate()
		instance.global_position = global_position
		get_tree().root.add_child(instance)
		instance.start()
		sprite_2d.visible = false
		drop_shadow.visible = false
		animation_player.play("on_hit")
		

func shoot(target: Vector2):
	self.target = target
	_direction = (target - global_position).normalized()
	_spawn_time = Time.get_unix_time_from_system()
	_activate()

func _activate():
	visible = true
	active = true
	hitbox.active = true

func _process(delta):
	if active:
		if Time.get_unix_time_from_system() - _spawn_time > time_to_live:
			queue_free()
		velocity = _direction * speed
		move_and_slide()


func _on_hitbox_area_entered(area):
	if area is Hurtbox and area.character.team != character.team: 
		on_hit()
