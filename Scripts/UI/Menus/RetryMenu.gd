extends CanvasItem

@onready var quit_button = $PanelContainer/VBoxContainer/Quit
@onready var retry_button = $PanelContainer/VBoxContainer/Retry


@export var path_to_scene_to_quit_to: String = "res://Scenes/Menus/MainMenu.tscn"
@export var path_to_scene_to_rerty: String

var focus_grabbed: bool = false

func _ready():
	visible = false
	retry_button.pressed.connect(On_Retry_Pressed)
	quit_button.pressed.connect(On_Quit_Pressed)
	
	GlobalSignalBus.player_died.connect(Show_Up)

func On_Retry_Pressed():
	visible = false
	SceneTransitionManager.Transition_To_Scene(path_to_scene_to_rerty)
	
func On_Quit_Pressed():
	visible = false
	SceneTransitionManager.Transition_To_Scene(path_to_scene_to_quit_to)
	
func Show_Up():
	visible = true
	get_tree().paused = true
	retry_button.grab_focus()
