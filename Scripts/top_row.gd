extends HBoxContainer

signal value_selected

@export var custom_name_bar:LineEdit
@export var name_presets_bar:OptionButton
@export var name_length_bar:SpinBox
#@export var estimated_use_bar:Label

@export var backend_name_length:int = 5
enum NameTypes {DECIMAL, HEXADECIMAL,ALPHABET,BASE64,WORD_BASED}
@export var current_name_type:NameTypes
var current_name_type_value:
	get:
		match current_name_type:
			NameTypes.DECIMAL: return 10
			NameTypes.HEXADECIMAL: return 16
			NameTypes.ALPHABET: return 26
			NameTypes.BASE64: return 64
			NameTypes.WORD_BASED: return FileAccess.open("res://Misc/words.txt",FileAccess.READ).get_as_text().split("\n").size()-1

func _ready() -> void:
	_refresh_all()

func _refresh_all():
	name_presets_bar.selected = %Backend.paste_name_algorithm
	name_length_bar.value = %Backend.paste_name_length

func _on_name_presets_item_selected(index: int) -> void:
	current_name_type = index as NameTypes
	%Backend.paste_name_algorithm = current_name_type
	SaveData.ram_save["paste_name_algorithm"] = index
	SaveData.save()
	#calculate_estimated_uses()

func _on_name_length_value_changed(value: float) -> void:
	backend_name_length = int(value)
	%Backend.paste_name_length = int(value)
	SaveData.ram_save["paste_name_length"] = int(value)
	SaveData.save()

func _on_custom_name_text_changed(new_text: String) -> void:
	if new_text != "":
		#estimated_use_bar.text = "Using a custom name"
		%Backend.custom_paste_name = new_text
