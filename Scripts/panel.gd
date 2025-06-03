extends Panel
class_name NotificationPanel

@export var content_node:RichTextLabel

@export_multiline var offline_error:String
@export_multiline var success_notice:String
@export_multiline var no_content_error:String
@export_multiline var no_filename_error:String
@export_multiline var filename_short_error:String
@export_multiline var content_too_big:String
@export_multiline var unknown_error:String
@export_multiline var footer:String

var main_content:String:
	set(new_content):
		main_content = new_content
		content_node.text = main_content
		show()

func set_main_content(dict:Dictionary):
	var error_text:String
	dict["code"] = int(dict["code"]) #Makes it an int so that we don't have issues.
	match dict["code"]:
		-1: error_text = offline_error
		0: error_text = success_notice
		1: error_text = no_content_error
		2: error_text = no_filename_error
		3: error_text = filename_short_error
		4: error_text = content_too_big
		5: error_text = no_content_error
		_: error_text = unknown_error
	
	error_text += "\n\n"+footer
	main_content = error_text.format(dict) # Contains "filename", "content" and "code"


func _on_content_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
