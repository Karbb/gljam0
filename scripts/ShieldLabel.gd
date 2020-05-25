extends Control


func _on_Enemy_shield_change(value : int) -> void:
	if value == 0:
		self.hide()
	else:
		self.show()
		var shield_label = "%s"
		$ShieldLabel.text = shield_label % [value]
