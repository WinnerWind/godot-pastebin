extends Panel
class_name NotificationPanel

var main_content:String:
	set(new_content):
		main_content = new_content
		$Sorter/Content.text = main_content
		show()

func set_main_content(dict:Dictionary):
	match int(dict["code"]):
		-1: main_content = "No response from server. Is it offline?"
		0: main_content = "Success!"
		1: main_content = "No content!"
		2: main_content = "No filename was specified"
		3: main_content = "Filename was too short. It must be at least 3 characters."
		4: main_content = "Content was too big! Keep it under 1 Million characters."
		5: main_content = "Content cannot be empty!"
