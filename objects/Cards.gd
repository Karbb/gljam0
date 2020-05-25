extends Node2D


func put_card():
	for child in get_children():
		if child.get_child_count() == 0:
			return child
