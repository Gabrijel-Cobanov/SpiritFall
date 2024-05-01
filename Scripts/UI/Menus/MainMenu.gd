extends Control

@onready var start_button = $Buttons/Start

var counter = 1

func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(On_Start_Button_Pressed)
	
func On_Start_Button_Pressed():
	get_tree().change_scene_to_file("res://Scenes/Gameplay.tscn")
