extends Node2D

var held_object = null

var card = preload("res://objects/Card.tscn")

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.connect("clicked", self, "_on_pickable_clicked")
	for node in get_tree().get_nodes_in_group("deck"):
		node.connect("clicked", self, "_on_deck_clicked")


func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()
		
func _on_deck_clicked(object):
	if !held_object and object:
		var card_instance = card.instance()
		card_instance.init(object)
		card_instance.global_transform.origin = get_global_mouse_position()
		add_child(card_instance)
		card_instance.connect("clicked", self, "_on_pickable_clicked")
		held_object = card_instance
		held_object.pickup()
		
	
func _unhandled_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null
		
		"""
		elif !held_object and event.doubleclick:
			var d = node.instance()
			d.init("D3")
			d.global_transform.origin = get_global_mouse_position()
			add_child(d)
			d.connect("clicked", self, "_on_pickable_clicked")
			"""
