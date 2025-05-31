extends Node
class_name PastebinNetworkBackend

# signals
signal paste_complete
signal out_of_filenames

@export_dir var export_path = "user://"
enum NewPasteAlgorithms {DECIMAL, HEXADECIMAL,ALPHABET,BASE64,WORD_BASED}
@export var paste_name_algorithm:NewPasteAlgorithms
@export_range(5,10) var paste_name_length:int = 5

var cached_content:String
var disallowed_names:Array[String] = []
func create_new_paste(content:String):
	cached_content = content
	var paste_name:String = ""
	match paste_name_algorithm:
		#region Randomized Functions
		NewPasteAlgorithms.DECIMAL:
			#Returns random number between 1 and largest possible pastenamelength digit number
			var found_working_filename:bool = false #Stores whether we have found a working filename or not.
			var tries:int = 1000
			while not found_working_filename:
				var max_possible_number = (10**(paste_name_length)) - 1
				var random_number = randi_range(1,max_possible_number)
				if tries <= 0:
					push_error("Couldn't find a working filename.")
					out_of_filenames.emit()
					return
				if not file_exists("%s.html"%random_number):
					paste_name = str(random_number)
					break
				else:
					tries -= 1
		NewPasteAlgorithms.HEXADECIMAL:
			var found_working_filename:bool = false #Stores whether we have found a working filename or not.
			var tries:int = 1000
			while not found_working_filename:
				# 16 cause hex
				var max_possible_number = (16**(paste_name_length)) - 1
				var random_number = randi_range(1,max_possible_number)
				if tries <= 0:
					push_error("Couldn't find a working filename.")
					out_of_filenames.emit()
					return
				if not file_exists("%x.html"%random_number):
					paste_name = "%x"%random_number
					break
				else:
					tries -= 1
		NewPasteAlgorithms.ALPHABET:
			var found_working_filename:bool = false #Stores whether we have found a working filename or not.
			var tries:int = 1000
			while not found_working_filename:
				# 26 cause alphabet
				var max_possible_number = (26**(paste_name_length)) - 1
				var random_number = randi_range(1,max_possible_number)
				if tries <= 0:
					push_error("Couldn't find a working filename.")
					out_of_filenames.emit()
					return
				if not file_exists("%s.html"%get_alphabet_from_number(random_number)):
					paste_name = get_alphabet_from_number(random_number)
					break
				else:
					tries -= 1
		NewPasteAlgorithms.BASE64:
			var found_working_filename:bool = false #Stores whether we have found a working filename or not.
			var tries:int = 1000
			while not found_working_filename:
				# you get the drill
				var max_possible_number = (64**(paste_name_length)) - 1
				var random_number = randi_range(1,max_possible_number)
				if tries <= 0:
					push_error("Couldn't find a working filename.")
					out_of_filenames.emit()
					return
				if not file_exists("%s.html"%get_base64_from_number(random_number)):
					paste_name = get_base64_from_number(random_number)
					break
				else:
					tries -= 1
		NewPasteAlgorithms.WORD_BASED:
			var found_working_filename:bool = false
			
			var tries:int = 1000
			while not found_working_filename:
				if tries <= 0:
					push_error("Couldn't find a working filename.")
					out_of_filenames.emit()
					return
				
				paste_name += get_random_word()
				for index in paste_name_length-1: #We added one in the previous line
					paste_name += "-"+get_random_word()
				
				if not file_exists("%s.html"%paste_name):
					break
				else:
					paste_name = ""
					tries -=1 
		#endregion
	send_file(content,paste_name)
	
	
	paste_complete.emit()

func send_file(content:String,filename:String):
	var url = "http://api.winnerwind.in/pastebin" #Replace this when necessary.
	var body = {"content": content, "filename":filename}
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.connect("request_completed", _on_request_completed)
	var err = $HTTPRequest.request(url,headers,HTTPClient.METHOD_POST,JSON.stringify(body))
	if err != OK:
		print("Request error: ", err)

func _on_request_completed(_result, _response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	print("Server response: "+str(response))
	if response.keys().has("error"):
		if response.error == "File exists!": #Retry with a different randomization.
			disallowed_names.append(response.filename)
			create_new_paste(cached_content)

#region Helper Functions
# Some helper functions
func file_exists(filename:String) -> bool:
	return FileAccess.file_exists(export_path+filename)

func get_alphabet_from_number(number:int) -> String:
	var result := ""
	while number > 0:
		number -= 1  # Adjust for 1-based inumberdexinumberg
		var remainumberder := number % 26
		result = char(65 + remainumberder) + result  # 65 is ASCII for 'A'
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
	
