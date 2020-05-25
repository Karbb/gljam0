extends KinematicBody2D

var direction : = Vector2()


func _process(delta: float) -> void:
	direction = get_input_direction()
	move_and_slide(direction * 60)

func get_input_direction() -> Vector2:
	var input_dir : = Vector2()
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input_dir
