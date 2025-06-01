extends HBoxContainer
class_name MiddleRow

func _on_theme_toggle_pressed() -> void:
	get_tree().current_scene._on_theme_toggle()
