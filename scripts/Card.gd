class_name Card

extends StaticBody2D

signal clicked
signal right_clicked
signal dice_applied

onready var front_sprite : Sprite = $SpriteFront
onready var back_sprite : Sprite = $SpriteBack
onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var area2D : Area2D = $Area2D
onready var dice_slot_sprite : Node2D = $DiceSlot/Sprite
onready var effect : Node = $Effect

var is_upwards : = true
var held : = false

export var suit : String = "H"
export var value : int = 1
export var code : String = "H1"

var collider

var dice = null

func init(code : String) -> void:
	self.suit = code[0]
	self.value = int(code[1])
	self.code = code
	

func _ready() -> void:
	var rect_pos_y : int
	var rect_pos_x : int
	
	match suit:
		"H": 
			rect_pos_y = 768
		"D":
			rect_pos_y = 816
		"F":
			rect_pos_y = 864
		"S":
			rect_pos_y = 912
			
	rect_pos_x = 960 + (value - 1) * 48
	
	var rect_pos : = Vector2(rect_pos_x, rect_pos_y)
	front_sprite.set_region_rect(Rect2(rect_pos, front_sprite.region_rect.size))
		
		
func _process(delta: float) -> void:
	check_side()
	check_dice_slot()
	
func _physics_process(delta: float) -> void:
	if held:
		global_transform.origin = get_global_mouse_position()


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			reverse()
			
			
func reverse() -> void:
	is_upwards = !is_upwards
	
	
func pickup():
	if !held:
		held = true


func drop():
	if held:
		held = false
		
		if collider and collider.is_in_group("deck"):
			collider.add_card(self)
			queue_free()
			
		if collider and collider.is_in_group("enemy"):
			collider.is_attacked(effect.get_calculated_effect(suit, value))
			queue_free()
			
		
		
func check_side():
	if is_upwards:
		front_sprite.visible = true
		back_sprite.visible = false
	else:
		front_sprite.visible = false
		back_sprite.visible = true
		
		
func check_dice_slot():
	if !dice:
		dice_slot_sprite.show()
	else:
		dice_slot_sprite.hide()
		

func add_dice(dice : int):
	emit_signal("dice_applied", dice)


func _on_Area2D_area_entered(area: Area2D) -> void:
	collider = area.get_owner()


func _on_Area2D_area_exited(area: Area2D) -> void:
	collider = null
