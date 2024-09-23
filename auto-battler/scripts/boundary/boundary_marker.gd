class_name BoundaryMarker extends Node2D

@onready var team_coloring = $TeamColoring

@export var team: int = 0

func _ready():
	if team == 0:
		team_coloring.modulate = Color.ROYAL_BLUE
	elif team == 1:
		team_coloring.modulate = Color.TOMATO
