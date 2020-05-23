extends Node

var dice_value : int

var effects = {
	"S" : { #SPADES
		1 : "1A+D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"H" : { #HEARTHS
		1 : "1C+D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"D" : { #DIAMONDS
		1 : "1S+D",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	},
	"F" : { #FLOWERS
		1 : "EW3",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	}
}


func _on_Card_dice_applied(value : int) -> void:
	dice_value = value
	

func get_calculated_effect(suit : String, card_value : int) -> String:
	return effects[suit][card_value].replace("D", str(dice_value))
