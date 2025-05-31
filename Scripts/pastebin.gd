extends Node
class_name PastebinBackend

@export_dir var export_path = "user://"
enum NewPasteAlgorithms {DECIMAL_SEQUENTIAL,DECIMAL,HEXADECIMAL_SEQUENTIAL,ALPHABET,ALPHABET_SEQUENTIAL,KEYBOARD,KEYBOARD_SEQUENTIAL}
@export var paste_name_algorithm:NewPasteAlgorithms
@export var paste_name_length:int = 5
func _ready() -> void:
	create_new_paste("Among us sus!")
	get_tree().root.queue_free()

func create_new_paste(content:String, paste_name:String = ""):
	match paste_name_algorithm:
		NewPasteAlgorithms.DECIMAL_SEQUENTIAL:
			var current_iteration:int = 0
			while file_exists(str(current_iteration)+".html"):
				current_iteration += 1
			paste_name = str(current_iteration)
	
	var file = FileAccess.open(export_path+paste_name+".html", FileAccess.WRITE) #Store file in export path
	file.store_string(content)

func file_exists(filename:String) -> bool:
	return FileAccess.file_exists(export_path+filename)
