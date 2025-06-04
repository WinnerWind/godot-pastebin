extends HBoxContainer
class_name MiddleRow

func _on_theme_toggle_pressed() -> void:
	get_tree().current_scene._on_theme_toggle()

func change_link_toggle_status(value:bool):
	if value: #link shortner is on
		$"Link Shorten Status".text = "Shortening Links"
	else:
		$"Link Shorten Status".text = "Pasting text"
