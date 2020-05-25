extends Node2D


func get_first_free_slot():
	for child in get_children():
		if child.get_child_count() == 0:
			return child
