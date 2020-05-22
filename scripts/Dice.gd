class_name Dice

extends StaticBody2D

signal clicked

var held : = false

var collider

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
		collider.add_dice(self)
		queue_free()
			
			
func _on_Area2D_area_entered(area: Area2D) -> void:
	collider = area.get_owner()


func _on_Area2D_area_exited(area: Area2D) -> void:
	collider = null
