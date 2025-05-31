extends Node
class_name PastebinBackend

@export_dir var export_path = "user://"

func _ready() -> void:
	create_new_paste("Among us sus!")

func create_new_paste(content:String, paste_name:String = ""):
	save_to_file(content,"test.html")

func save_to_file(content:String,path:String):
	var file = FileAccess.open(export_path+path, FileAccess.WRITE)
	file.store_string(content)
