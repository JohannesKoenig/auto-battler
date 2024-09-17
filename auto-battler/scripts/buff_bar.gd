class_name BuffBar extends HBoxContainer

var _character_buff_system: CharacterBuffSystem
@onready var buff_display: PackedScene = preload("res://scenes/buff_display.tscn")

var displayed_buffs = {}

func accept_buff_system(buff_system: CharacterBuffSystem):
	_character_buff_system = buff_system

func _process(delta):
	var buffs = _character_buff_system.buffs.keys()
	for buff in buffs:
		if buff in displayed_buffs:
			continue
		var buff_display_instance = buff_display.instantiate()
		buff_display_instance.texture = _character_buff_system.buffs[buff].texture
		displayed_buffs[buff] = buff_display_instance
		add_child(buff_display_instance)
	
	var keys_to_delete = []
	for displayed_buff in displayed_buffs.keys():
		if displayed_buff not in buffs:
			var display = displayed_buffs[displayed_buff]
			display.queue_free()
			remove_child(display)
			keys_to_delete.append(displayed_buff)
	
	for key in keys_to_delete:
		displayed_buffs.erase(key)
