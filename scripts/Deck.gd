extends Node2D

signal card_change
signal clicked

var cards : Array = []

var can_extract = true

func _ready() -> void:
	emit_signal("card_change", cards)

func add_card(card) -> void:
	cards.append(str(card.suit) + str(card.value))
	emit_signal("card_change", cards)
	
func pick_card() -> void:
	var card = cards.pop_back()
	emit_signal("card_change", cards)
	emit_signal("clicked", card)
	
	
func shuffle_deck() -> void:
	cards.shuffle()
	

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			pick_card()
