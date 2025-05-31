extends Node
class_name PastebinBackend

@export_dir var export_path = "user://"
enum NewPasteAlgorithms {DECIMAL_SEQUENTIAL,DECIMAL,HEXADECIMAL_SEQUENTIAL,ALPHABET,ALPHABET_SEQUENTIAL,KEYBOARD,KEYBOARD_SEQUENTIAL}
@export var paste_name_algorithm:NewPasteAlgorithms
@export var paste_name_length:int = 5
func _ready() -> void:
	for i in 16:
		create_new_paste("Among us sus!")
	get_tree().root.queue_free()

func create_new_paste(content:String, paste_name:String = ""):
	match paste_name_algorithm:
		NewPasteAlgorithms.DECIMAL_SEQUENTIAL:
			var current_iteration:int = 0
			while file_exists("%d.html"%current_iteration):
				current_iteration += 1
			paste_name = "%d"%current_iteration
		NewPasteAlgorithms.HEXADECIMAL_SEQUENTIAL:
			var current_iteration:int = 0
			while file_exists("%x.html"%current_iteration):
				current_iteration += 1
			paste_name = "%x"%current_iteration
		NewPasteAlgorithms.ALPHABET_SEQUENTIAL:
			var current_iteration:int = 0
			while file_exists("%s.html"%get_alphabet_from_number(current_iteration)):
				current_iteration += 1
			paste_name = "%s"%get_alphabet_from_number(current_iteration)
	
	var file = FileAccess.open(export_path+paste_name+".html", FileAccess.WRITE) #Store file in export path
	file.store_string(content)

func file_exists(filename:String) -> bool:
	return FileAccess.file_exists(export_path+filename)

# Some helper functions
#func to_hex(number:int) -> String:
	#var quotient = number/16
	#var remainder = number%16
	#var hex_table = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e"]
	#return "%s%s"%[quotient,hex_table[remainder-1]]

func get_alphabet_from_number(number:int) -> String:
	var result := ""
	while number > 0:
		number -= 1  # Adjust for 1-based inumberdexinumberg
		var remainumberder := number % 26
		result = char(65 + remainumberder) + result  # 65 is ASCII for 'A'
		number = number / 26
	return result.to_lower()
