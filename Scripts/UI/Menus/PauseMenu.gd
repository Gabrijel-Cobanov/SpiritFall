extends CanvasItem

@onready var resume = $PanelContainer/Buttons/Resume
@onready var options = $PanelContainer/Buttons/Options
@onready var quit = $PanelContainer/Buttons/Quit
@onready var input_settings = $InputSettings
@onready var panel_container = $PanelContainer

@onready var button_click = $ButtonClick
@onready var button_hover = $ButtonHover


@export var path_to_scene_to_quit_to: String = "res://Scenes/Menus/MainMenu.tscn"

var focus_grabbed: bool = false

func _ready():
	visible = false
	
	resume.pressed.connect(On_Resume_Pressed)
	options.pressed.connect(Toggle_Elements_Visibility)
	quit.pressed.connect(On_Quit_Pressed)
	
	resume.pressed.connect(Play_Click_Sound)
	options.pressed.connect(Play_Click_Sound)
	quit.pressed.connect(Play_Click_Sound)
	
	resume.focus_entered.connect(Play_Hover_Sound)
	options.focus_entered.connect(Play_Hover_Sound)
	quit.focus_entered.connect(Play_Hover_Sound)
	

func _process(delta):
	if Input.is_action_just_pressed("pause_game") and !get_tree().paused:
		visible = true
		get_tree().paused = true
		resume.grab_focus()
	elif Input.is_action_just_pressed("pause_game") and input_settings.visible:
		Toggle_Elements_Visibility()
		resume.grab_focus()
	elif Input.is_action_just_pressed("pause_game") and get_tree().paused:
		visible = false
		get_tree().paused = false
		
func On_Resume_Pressed():
	visible = false
	get_tree().paused = false
	
	
func On_Quit_Pressed():
	SceneTransitionManager.Transition_To_Scene(path_to_scene_to_quit_to)
	
func Toggle_Elements_Visibility():
	panel_container.visible = !panel_container.visible
	input_settings.visible = !input_settings.visible
	
func Play_Hover_Sound():
	button_hover.play()
	
func Play_Click_Sound():
	button_click.pitch_scale = randf_range(0.95, 1.05)
	button_click.play()
