extends VBoxContainer
class_name MainUI

@export var content_entry:TextEdit
func _submit_pressed():
	%Backend.create_new_paste(content_entry.text)
