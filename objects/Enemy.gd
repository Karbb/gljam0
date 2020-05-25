extends StaticBody2D

signal health_change
signal shield_change
signal effect_change
signal attack_finished

export var max_hp : int = 20

onready var hp : int = max_hp

var shield : int = 0

var effect_dict = {}

func _ready() -> void:
	emit_signal("health_change", hp, max_hp)
	emit_signal("shield_change", shield)
	emit_signal("effect_change", effect_dict)


func is_attacked(effect : String):
	var effect_arr = effect.split(",")
	
	match effect_arr[0]:
		"A" :
			var attack_value = int(effect_arr[1])
			if shield > 0:
				var remaining_attack_value = max(0, attack_value - shield)
				shield = max(0, shield - attack_value)
				attack_value = remaining_attack_value
			hp = hp - attack_value
		"C" :
			var heal_value = int(effect_arr[1])
			hp = min(max_hp, hp + int(effect_arr[1]))
		"S" :
			shield = shield + int(effect_arr[1])
		"W" :
			effect_dict["W"] = int(effect_arr[1])
	
	emit_signal("shield_change", shield)
	emit_signal("health_change", hp, max_hp)
	emit_signal("effect_change", effect_dict)
	
func attack():
	shield = 0
	for key in effect_dict.keys():

		effect_dict[key] = effect_dict[key] - 1
		if effect_dict[key] < 1:
			effect_dict.erase(key)
			
	emit_signal("effect_change", effect_dict)
	emit_signal("shield_change", shield)
	
	$AnimationPlayer.play("Attack")
	
func attack_finished():
	emit_signal("attack_finished")
