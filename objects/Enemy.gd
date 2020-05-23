extends StaticBody2D

signal health_change

var max_hp : int = 20

var hp : int = max_hp


func _ready() -> void:
	emit_signal("health_change", hp, max_hp)


func is_attacked(effect : String):
	print(effect)
	hp = hp - 1
