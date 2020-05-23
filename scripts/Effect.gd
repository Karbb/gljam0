extends Node

var dice_value : int

var effects = {
	"S" : { #SPADES
		1 : "A:D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"H" : { #HEARTHS
		1 : "C:D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"D" : { #DIAMONDS
		1 : "S:D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"F" : { #FLOWERS
		1 : "W:D-1",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	}
}


func _on_Card_dice_applied(value : int) -> void:
	dice_value = value
	

func get_calculated_effect(suit : String, card_value : int) -> String:
	
	var card_effect = effects[suit][card_value].replace("D", str(dice_value)).split(":")
	
	var e = Expression.new()
	e.parse(card_effect[1])
	
	return card_effect[0] + "," + str(e.execute())
