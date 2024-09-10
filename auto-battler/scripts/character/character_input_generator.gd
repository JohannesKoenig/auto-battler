class_name CharacterInputGenerator extends Node2D


@export var pick_up_area: PickUpArea
@export var target_scanner_area: TargetScannerArea
@export var hurtbox: Hurtbox


func get_input() -> CharacterInput:
	return CharacterInput.new()
	
