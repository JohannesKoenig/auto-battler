class_name OnHitEffect extends Node
@onready var gpu_particles_2d = $GPUParticles2D

func start():
	gpu_particles_2d.emitting = true
