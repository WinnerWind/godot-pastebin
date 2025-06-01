extends Panel
class_name BG

@export var light_theme:Theme
@export var dark_theme:Theme

func _on_theme_toggle():
	if theme == dark_theme:
		theme = light_theme
	else:
		theme = dark_theme
