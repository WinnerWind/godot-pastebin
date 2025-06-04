extends Panel
class_name BG

@export var themes:Array[Theme]
@export var current_theme:int:
	set(new_num):
		if new_num > themes.size()-1:
			new_num = 0
		current_theme = new_num
		

func _ready() -> void:
	current_theme = SaveData.ram_save["theme"]
	theme = themes[current_theme]

func _on_theme_toggle():
	current_theme+=1
	theme = themes[current_theme]
	SaveData.ram_save["theme"] = current_theme
	SaveData.save()
