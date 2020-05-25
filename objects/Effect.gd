extends HBoxContainer




func _on_Enemy_effect_change(effect_dict : Dictionary) -> void:
	for child in get_children():
		child.hide()
	
	for effect in effect_dict.keys():
		get_node(str(effect)).show()
		get_node(str(effect)).get_child(1).text = str(effect_dict[effect])
