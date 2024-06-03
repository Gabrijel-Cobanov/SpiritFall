extends Control

@onready var start_button: Button = $Buttons/Start
@onready var exit_button = $Buttons/Exit
var counter = 1 

func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(On_Start_Button_Pressed)
	exit_button.pressed.connect(On_Exit_Pressed)
	
	#Upon first start up, make a game_data file, only one save file, to not complicate things
	var game_data = SaveSystem.get_var("save_file_1")
	if not game_data:
		game_data = GameData.new()
		SaveSystem.set_var("save_file_1", game_data)
		SaveSystem.save()
	
	
	
func On_Start_Button_Pressed():
	SceneTransitionManager.Transition_To_Scene("res://Scenes/Levels/HubWorld.tscn")
	
func On_Exit_Pressed():
	get_tree().quit()
