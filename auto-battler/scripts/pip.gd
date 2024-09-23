class_name Pip extends TextureRect

@onready var inactive_pip: Texture = preload("res://assets/pip_deactivated.png")
@onready var active_pip: Texture = preload("res://assets/pip_activated.png")


func _ready():
	deactivate()

func deactivate():
	texture = inactive_pip

func activate():
	texture = active_pip
