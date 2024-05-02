extends Control

@onready var start_button: Button = $Buttons/Start
@onready var exit_button = $Buttons/Exit


var counter = 1 

func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(On_Start_Button_Pressed)
	exit_button.pressed.connect(On_Exit_Pressed)
	
func On_Start_Button_Pressed():
	SceneTransitionManager.Transition_To_Scene("res://Scenes/Gameplay.tscn")
	
func On_Exit_Pressed():
	get_tree().quit()
