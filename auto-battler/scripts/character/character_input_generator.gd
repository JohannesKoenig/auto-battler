class_name CharacterInputGenerator extends Node2D


@export var pick_up_area: PickUpArea
@export var target_scanner_area: TargetScannerArea
var dragging_target: Vector2


func get_input() -> CharacterInput:
	return CharacterInput.new()
	

func inject_dragging(target: Vector2):
	pick_up_area.inject_dragging(target)

func break_dragging():
	pick_up_area.break_dragging()
