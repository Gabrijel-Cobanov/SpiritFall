extends Control

@onready var start_button: Button = $Buttons/Start
@onready var exit_button = $Buttons/Exit

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	start_button.grab_focus()
	start_button.pressed.connect(On_Start_Button_Pressed)
	exit_button.pressed.connect(On_Exit_Pressed)
	
	#Upon first start up, make a game_data file, only one save file, to not complicate things
	var game_data = SaveSystem.get_var("save_file_1")
	if game_data == null:
		print("Data was null")
		game_data = GameData.new()
		print(game_data)
		print("Game data was null, saving this %s", [game_data])
		SaveSystem.set_var("save_file_1", game_data)
		SaveSystem.save()
	else:
		print("Data was not null, loaded this %s", [game_data])
	
func On_Start_Button_Pressed():
	SceneTransitionManager.Transition_To_Scene("res://Scenes/Levels/HubWorld.tscn")
	
func On_Exit_Pressed():
	var game_data = SaveSystem.get_var("save_file_1")
	SaveSystem.set_var("save_file_1", game_data)
	SaveSystem.save()
	get_tree().quit()
