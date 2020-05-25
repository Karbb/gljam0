extends Node2D

var held_object = null

signal change_description

var card = preload("res://objects/Card.tscn")
var dice = preload("res://objects/Dice.tscn")

var turn = "PLAYER"

var dices = []
var cards = []

var dice_number = 2

func _ready():
	randomize()
	
	player_turn()

	for node in get_tree().get_nodes_in_group("deck"):
		node.connect("clicked", self, "_on_deck_clicked")
		node.connect("move_card", self, "_on_card_moved")

		
func _process(delta: float) -> void:
	if dice_number == 0:
		$Deck.move_to_deck_to_shuffle(cards)
		cards.clear()
	
	if dice_number == 0 and turn == "PLAYER":
		turn = "ENEMY"
		
		yield(get_tree().create_timer(0.5), "timeout")
		
		enemy_turn()


func enemy_turn():
	for enemy in $Enemies.get_children():
		enemy.attack()

		yield(enemy, "attack_finished")
		
	player_turn()


func player_turn():
	turn = "PLAYER"
	generate_dice(2)
	give_card(5)

func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()
		
		
func _on_card_used(value):
	dice_number = dice_number - 1
	cards.erase(value)
	$Deck.erase_card(value)
	

func give_card(quantity : int):
	if $Deck.count_cards() < quantity:
		$Deck.restore_deck()
	
	for i in quantity:
		var card_from_deck = $Deck.get_card()
		cards.append(card_from_deck)
		var card_instance = card.instance()
		card_instance.init(card_from_deck)
		var location = $Cards.get_first_free_slot()
		location.add_child(card_instance)
		card_instance.connect("clicked", self, "_on_pickable_clicked")
		card_instance.connect("hovered", self, "_on_card_hovered")
		card_instance.connect("used", self, "_on_card_used")
		
		
func generate_dice(quantity : int):
	for i in range(quantity):
		var dice_instance = dice.instance()
		var location = $Dice.get_first_free_slot()

		dice_instance.init(randi() % 6 + 1)
		
		location.add_child(dice_instance)
		dice_instance.connect("clicked", self, "_on_pickable_clicked")
		$Dice.add_child(dice_instance)
		dices.append(dice_instance)
		
	dice_number = quantity
		
func _on_card_hovered(description):
	emit_signal("change_description", description)
		
func _on_deck_clicked(object):
	if !held_object and object:
		var card_instance = card.instance()
		card_instance.init(object)
		card_instance.global_transform.origin = get_global_mouse_position()
		add_child(card_instance)
		card_instance.connect("clicked", self, "_on_pickable_clicked")
		card_instance.connect("hovered", self, "_on_card_hovered")
		card_instance.connect("used", self, "_on_card_used")
		held_object = card_instance
		held_object.pickup()
		
		
func _on_card_moved(object):
	var card_instance = card.instance()
	card_instance.init(object)
	var location = $Cards.put_card()
	card_instance.global_transform.origin = location.global_transform.origin
	location.add_child(card_instance)
	card_instance.connect("clicked", self, "_on_pickable_clicked")
	card_instance.connect("hovered", self, "_on_card_hovered")
	card_instance.connect("used", self, "_on_card_used")
		
	
func _unhandled_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null
