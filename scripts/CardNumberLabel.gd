extends Label



func _on_Deck_card_change(cards : Array) -> void:
	self.text = str(cards.size())
