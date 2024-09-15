extends Control

@onready var logo = $TextureRect
@onready var buttons = $Buttons
@onready var start_button: Button = $Buttons/Start
@onready var options_button = $Buttons/Options
@onready var exit_button = $Buttons/Exit
@onready var input_settings = $InputSettings

@onready var button_click = $ButtonClick
@onready var button_hover = $ButtonHover

@onready var animation_player = $AnimationPlayer

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animation_player.play("fade_in")
	start_button.grab_focus()
	start_button.pressed.connect(On_Start_Button_Pressed)
	options_button.pressed.connect(Toggle_Elements_Visibility)
	exit_button.pressed.connect(On_Exit_Pressed)
	
	start_button.pressed.connect(Play_Click_Sound)
	options_button.pressed.connect(Play_Click_Sound)
	exit_button.pressed.connect(Play_Click_Sound)
	
	start_button.focus_entered.connect(Play_Hover_Sound)
	options_button.focus_entered.connect(Play_Hover_Sound)
	exit_button.focus_entered.connect(Play_Hover_Sound)
	
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
		
func _unhandled_input(event):
	if input_settings.visible and event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Toggle_Elements_Visibility()
			start_button.grab_focus()
	
func On_Start_Button_Pressed():
	SceneTransitionManager.Transition_To_Scene("res://Scenes/Levels/HubWorld.tscn")
	
func On_Exit_Pressed():
	var game_data = SaveSystem.get_var("save_file_1")
	SaveSystem.set_var("save_file_1", game_data)
	SaveSystem.save()
	get_tree().quit()
	
func Toggle_Elements_Visibility():
	logo.visible = !logo.visible
	buttons.visible = !buttons.visible
	input_settings.visible = !input_settings.visible
	
func Play_Hover_Sound():
	button_hover.play()
	
func Play_Click_Sound():
	button_click.pitch_scale = randf_range(0.95, 1.05)
	button_click.play()
	
	
