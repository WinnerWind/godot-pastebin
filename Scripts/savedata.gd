extends Node

var save_path = "user://savedata.save" #Path of savedata
var save_backup_path = "user://savedata.savebak"

#Also acts as default save values.
var ram_save = {
	"theme": 0,
	"paste_name_length": 5,
	"paste_name_algorithm": 0
}: #SaveData currently being accessed by the game
	set(new_save):
		ram_save = new_save
		save()

var disk_save #SaveData from the system, on disk
func save():
	# Function to copy ram_save into disk_save
	#Make a backup
	if FileAccess.file_exists(save_path):
		var dir = DirAccess.open("user://")
		dir.copy(save_path,save_backup_path)
	
	disk_save = FileAccess.open(save_path,FileAccess.WRITE)
	disk_save.store_var(ram_save)
	disk_save.close()

func delete_save():
	#Function to delete the save
	DirAccess.remove_absolute(save_path)

func load_save():
	if FileAccess.file_exists(save_path):
		disk_save = FileAccess.open(save_path,FileAccess.READ) #Open the disk save and save it
		
		var temp_save:Dictionary = disk_save.get_var()
		
		#Prevents conflict
		if not temp_save.keys() == ram_save.keys(): #Some keys are missing.
			var missing_keys:Array = ram_save.keys() #Assume all keys are missing
			for key in ram_save.keys():
				if temp_save.has(key):
					missing_keys.erase(key) #Erase the keys one by one which already exist.
			
			for key in missing_keys:
				temp_save[key] = ram_save[key] #Set them to be the default value.
		
		ram_save = temp_save # read from file. Also make ramsave = disksave, hence loading it.
		
		disk_save.close() #Close the disk save as we don't need it.
	else: #Save doesnt exist so just make one, lol
		save()
	print(ram_save)


func _ready():
	#delete_save()
	load_save()
#endregion
