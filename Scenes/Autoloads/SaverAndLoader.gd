extends Node2D

const SAVE_DIR = "user://saves/"
const PLAYER_SAVE_FILE_NAME = "player_save.json"
const GAME_SAVE_FILE_NAME = "game_save.json"
const SECURITY_KEY = "0036540960"

func _ready():
	Verify_Save_Dir(SAVE_DIR)
	
func Verify_Save_Dir(path):
	DirAccess.make_dir_absolute(path)


func Save_Game_Data(path, game_data: GameData):
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
		
	var data = {
		"game_data": {
			"total_found_totems"	: game_data.total_found_totems,
			"found_totem_ids"		: game_data.found_totem_ids,
			"completed_level_ids"	: game_data.completed_level_ids
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()
	
	
func Load_Game_Data(path):
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
			return
		
		var game_data =GameData.new()
		game_data.total_found_totems = data.game_data.total_found_totems
		game_data.found_totem_ids = data.game_data.found_totem_ids
		game_data.completed_level_ids = data.game_data.completed_level_ids
		
		return game_data
		
	else:
		printerr("Cannot open non-existent file at %s" % [path])
		return
	
	
func Save_Player_Data(path, player_data: PlayerData):
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
		
	var data = {
		"player_data": {
			"max_combo_counter": player_data.max_combo_counter
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()
	
	
func Load_Player_Data(path):
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
			return
		
		var player_data = PlayerData.new()
		player_data.max_combo_counter = data.player_data.max_combo_counter
		
		return player_data
		
	else:
		printerr("Cannot open non-existent file at %s" % [path])
