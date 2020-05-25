extends Label



func _on_Enemy_health_change(hp : int, max_hp : int) -> void:
	var hp_label = "%s / %s"
	text = hp_label % [hp, max_hp]
