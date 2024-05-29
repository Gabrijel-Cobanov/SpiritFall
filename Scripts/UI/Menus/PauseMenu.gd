extends CanvasItem

@onready var resume = $PanelContainer/VBoxContainer/Resume
@onready var options = $PanelContainer/VBoxContainer/Options
@onready var quit = $PanelContainer/VBoxContainer/Quit


@export var path_to_scene_to_quit_to: String = "res://Scenes/Menus/MainMenu.tscn"

var focus_grabbed: bool = false

func _ready():
	visible = false
	
	resume.pressed.connect(On_Resume_Pressed)
	quit.pressed.connect(On_Quit_Pressed)
	

func _process(delta):
	if Input.is_action_just_pressed("pause_game") and !get_tree().paused:
		visible = true
		get_tree().paused = true
		resume.grab_focus()
	elif Input.is_action_just_pressed("pause_game") and get_tree().paused:
		visible = false
		get_tree().paused = false

func On_Resume_Pressed():
	visible = false
	get_tree().paused = false
	
func On_Quit_Pressed():
	SceneTransitionManager.Transition_To_Scene(path_to_scene_to_quit_to)
