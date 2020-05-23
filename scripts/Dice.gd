class_name Dice

extends StaticBody2D

signal clicked

var held : = false

var collider

export(int, 1, 6) var value : int = 1

onready var sprite : Sprite = $Sprite


func init(value : int) -> void:
	self.value = value
	

func _ready() -> void:
	var rect_pos_x = 2016 + (value - 1) * 48
	var rect_pos_y = 672
	
	var rect_pos : = Vector2(rect_pos_x, rect_pos_y)
	sprite.set_region_rect(Rect2(rect_pos, sprite.region_rect.size))

func _physics_process(delta: float) -> void:
	if held:
		global_transform.origin = get_global_mouse_position()


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
		
	
func pickup():
	if !held:
		held = true


func drop():
	if held:
		held = false
		
	if collider and collider.is_in_group("card"):
		collider.add_dice(self.value)
		queue_free()
			
			
func _on_Area2D_area_entered(area: Area2D) -> void:
	collider = area.get_owner()
	print('enter')


func _on_Area2D_area_exited(area: Area2D) -> void:
	collider = null
	print('exit')
