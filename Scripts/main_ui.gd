extends VBoxContainer
class_name MainUI

@export var content_entry:TextEdit
@export var name_entry:LineEdit

func _submit_pressed():
	%Backend.custom_paste_name = name_entry.text
	%Backend.create_new_paste(content_entry.text)
