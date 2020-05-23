extends Node2D

onready var sprite : Sprite = $Sprite

func _on_Card_dice_applied(value : int) -> void:
	var rect_pos_x = 2016 + (value - 1) * 48
	var rect_pos_y = 672
	
	var rect_pos : = Vector2(rect_pos_x, rect_pos_y)
	sprite.set_region_rect(Rect2(rect_pos, sprite.region_rect.size))
	
