extends Panel
class_name NotificationPanel

var main_content:String:
	set(new_content):
		main_content = new_content
		$Sorter/Content.text = main_content
		show()

func set_main_content(content:String):
	main_content = content
