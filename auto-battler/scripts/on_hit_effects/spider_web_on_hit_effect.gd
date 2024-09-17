class_name SpiderWebOnHitEffect extends OnHitEffect

@onready var ring_particles = $RingParticles
@onready var ring = $Ring
@onready var animation_player = $AnimationPlayer
@onready var hitbox = $Hitbox
@export var character: Character:
	set(value):
		character = value
		hitbox.character = value


func _ready():
	ring_particles.emitting = false
	ring.visible = false

func start():
	super()
	ring_particles.emitting = true
	ring.visible = true
	animation_player.play("effect")
	hitbox.active = true
	
