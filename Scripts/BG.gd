extends Panel
class_name BG

@export var themes:Array[Theme]
@export var current_theme:int:
	set(new_num):
		if new_num > themes.size()-1:
			new_num = 0
		current_theme = new_num

func _ready() -> void:
	theme = themes[0]

func _on_theme_toggle():
	current_theme+=1
	theme = themes[current_theme]
