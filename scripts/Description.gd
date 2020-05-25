extends Control


func _ready() -> void:
	write("")


func write(text : String) -> void:
	self.text = text


func _on_GameArea_change_description(description : String) -> void:
	write(description)
