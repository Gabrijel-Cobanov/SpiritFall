extends CanvasItem

@onready var resume_button: Button = $PanelContainer/VBoxContainer/Resume
@onready var options_button: Button = $PanelContainer/VBoxContainer/Options
@onready var quit_button: Button = $PanelContainer/VBoxContainer/Quit

var focus_grabbed: bool = false

func _ready():
	visible = false
	
	resume_button.pressed.connect(On_Resume_Pressed)
	quit_button.pressed.connect(On_Quit_Pressed)


func _process(delta):
	if Input.is_action_just_pressed("pause_game"):
		visible = !visible
		get_tree().paused = visible
		resume_button.grab_focus()
		
func On_Resume_Pressed():
	visible = false
	get_tree().paused = false
	
func On_Quit_Pressed():
	SceneTransitionManager.Transition_To_Scene("res://Scenes/Menus/MainMenu.tscn")
