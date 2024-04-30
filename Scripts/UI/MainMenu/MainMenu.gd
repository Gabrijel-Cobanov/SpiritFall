extends Control

@onready var start_button: Button = $VBoxContainer/Start
@onready var options_button: Button = $VBoxContainer/Options
@onready var quit_button: Button = $VBoxContainer/Quit

const GAMEPLAY = preload("res://Scenes/Gameplay.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.grab_focus()
	
	start_button.pressed.connect(On_Start_Button_Pressed)
	
func On_Start_Button_Pressed():
	get_tree().change_scene_to_packed(GAMEPLAY)

