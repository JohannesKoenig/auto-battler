class_name CharacterBuffSystem extends Node

var buffs = {}

func _ready():
	for child in get_children():
		if child is CharacterBuff:
			buffs[child.name] = child

func _process(delta):
	var keys_to_erase = []
	for buff in buffs.keys():
		var buff_node = buffs[buff]
		if buff_node != null and not buff_node.is_active():
			buff_node.queue_free()
			keys_to_erase.append(buff)
	for key in keys_to_erase:
		buffs.erase(key)


func add_buff(character_buff: CharacterBuff):
	var new_instance = character_buff.duplicate()
	if new_instance.name in buffs and buffs[new_instance.name] != null:
		remove_child(buffs[new_instance.name])
		buffs[new_instance.name].queue_free()
	buffs[new_instance.name] = new_instance
	new_instance.activate()
	add_child(new_instance)

	
