extends Node2D

signal card_change
signal clicked

export var cards : Array = []
export var deck_to_shuffle : Array = []

var can_extract = true

func _ready() -> void:
	emit_signal("card_change", cards)

func add_card(card) -> void:
	cards.append(str(card.suit) + str(card.value))
	emit_signal("card_change", cards)
	
func get_card():
	var card = cards.pop_back()
	emit_signal("card_change", cards)
	return card
	
func shuffle_deck() -> void:
	cards.shuffle()
	
func count_cards() -> int:
	return cards.size()
	
func erase_card(value):
	cards.erase(value)
	deck_to_shuffle.append(value)
	
	
func restore_deck():
	cards = cards + deck_to_shuffle
	shuffle_deck()
	
func move_to_deck_to_shuffle(value : Array):
	deck_to_shuffle = deck_to_shuffle + value
