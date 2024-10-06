class_name AiExploreTask extends AiTask

var duration: float = 1.0
var dragged_character: Character
var target: Vector2

func transition(input: AiInput) -> String:
	if _has_passed(duration):
		return "Idle"
	return name

func on_enter(input: AiInput):
	dragged_character = input.dragged_character
	target = input.dragging_target
	dragged_character.character_input.inject_dragging(target)
	super(input)

func on_exit(input: AiInput):
	dragged_character.character_input.break_dragging()
	super(input)
