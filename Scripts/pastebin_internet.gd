extends Node
class_name PastebinNetworkBackend

# signals
signal paste_complete
signal send_prompt(content:String)
signal settings_changed

enum NewPasteAlgorithms {DECIMAL, HEXADECIMAL,ALPHABET,BASE64,WORD_BASED}
@export var paste_name_algorithm:NewPasteAlgorithms:
	set(new_val):
		paste_name_algorithm = new_val
		settings_changed.emit()
@export_range(3,10) var paste_name_length:int = 5:
	set(new_val):
		paste_name_length = new_val
		settings_changed.emit()
		
func _ready() -> void:
	paste_name_length = SaveData.ram_save["paste_name_length"]
	paste_name_algorithm = SaveData.ram_save["paste_name_algorithm"]

var cached_content:String
#var disallowed_names:Array[String] = []
var custom_paste_name:String
var is_link:bool
func create_new_paste(content:String):
	cached_content = content
	var paste_name:String = ""
	if not custom_paste_name: match paste_name_algorithm:
			NewPasteAlgorithms.DECIMAL:
				#Returns random number between 1 and largest possible pastenamelength digit number
				var max_possible_number = (10**(paste_name_length)) - 1
				var random_number = randi_range(10*3,max_possible_number) #paste must be 3chr long
				paste_name = str(random_number)
			NewPasteAlgorithms.HEXADECIMAL:
				var max_possible_number = (16**(paste_name_length)) - 1
				var random_number = randi_range(16*3,max_possible_number) #paste must be at least 16 characters long.
				paste_name = "%x"%random_number
			NewPasteAlgorithms.ALPHABET:
				# 26 cause alphabet
				var max_possible_number = (26**(paste_name_length)) - 1
				var random_number = randi_range(26*3,max_possible_number) #The paste must be at least 3 characters.
				paste_name = get_alphabet_from_number(random_number)
			NewPasteAlgorithms.BASE64:
				# you get the drill
				var max_possible_number = (64**(paste_name_length)) - 1
				var random_number = randi_range(64*3,max_possible_number)
				paste_name = get_base64_from_number(random_number)
			NewPasteAlgorithms.WORD_BASED:
				paste_name += get_random_word()
				for index in paste_name_length-1: #We added one in the previous line
					paste_name += "-"+get_random_word()
	else: #Custom paste name. Slugify.
		paste_name = custom_paste_name
		paste_name = paste_name.to_lower()
		paste_name = paste_name.replace(" ","-")
	send_file(content,paste_name)
	
	paste_complete.emit()

func send_file(content:String,filename:String):
	#var file = FileAccess.open("res://secrets/url.txt",FileAccess.READ)
	#var url = file.get_as_text().trim_suffix("\n") #Replace this when necessary.
	var url = "https://api.winnerwind.in/pastebin"
	var body = {"content": content, "filename":filename, "is_link":is_link}
	var headers = ["Content-Type: application/json", "Access-Control-Allow-Origin: *"]
	var err = $HTTPRequest.request(url,headers,HTTPClient.METHOD_POST,JSON.stringify(body))
	if err != OK:
		print("Request error: ", err)

func _on_request_completed(_result, _response_code, _headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	print("Server response: "+str(response))
	if not response == null:
		send_prompt.emit(response)
		if response.keys().has("error"):
			if response.error == "File exists!": #Retry with a different randomization.
				#disallowed_names.append(response.filename)
				create_new_paste(cached_content)
	else:
		send_prompt.emit({"code":-1})
	

#region Helper Functions
func get_alphabet_from_number(number:int) -> String:
	var alphabet = "abcdefghijklmnopqrstuvwxyz"
	var result := ""
	if number == 0:
		return alphabet[0]
	while number > 0:
		var remainder = number % 26
		result = alphabet[remainder] + result
		number = number / 26
	return result.to_lower()

func get_base64_from_number(number:int):
	var base64_chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_"
	var result := ""
	if number == 0:
		return base64_chars[0]
	while number > 0:
		var remainumberder = number % 64
		result = base64_chars[remainumberder] + result
		number = number / 64
	return result

func get_random_word():
	var file = FileAccess.open("res://Misc/words.txt",FileAccess.READ_WRITE)
	var words:Array = Array(file.get_as_text().split("\n")).filter(func(t): return t)
	return words.pick_random()
#endregion
	
func _set_link_shortener_mode(value:bool):
	is_link = value
	
