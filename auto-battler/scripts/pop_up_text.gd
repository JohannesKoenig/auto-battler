class_name PopUpText extends Label

var _target_position: Vector2
var tween: Tween

func _ready():
	_target_position = position + Vector2(randf_range(-5, 5), -5)
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", _target_position, 0.5)
	tween.tween_callback(queue_free)

static func get_damage(value: int) -> PopUpText:
	var pop_up_text = PopUpText.new()
	pop_up_text.add_theme_font_size_override("font_size", 4)
	pop_up_text.text = str(value)
	pop_up_text.modulate = Color.RED
	return pop_up_text

static func get_healing(value: int) -> PopUpText:
	var pop_up_text = PopUpText.new()
	pop_up_text.add_theme_font_size_override("font_size", 4)
	pop_up_text.text = str(value)
	pop_up_text.modulate = Color.GREEN
	return pop_up_text

static func get_neutral(neutral_text: String) -> PopUpText:
	var pop_up_text = PopUpText.new()
	pop_up_text.add_theme_font_size_override("font_size", 4)
	pop_up_text.text = neutral_text
	return pop_up_text
