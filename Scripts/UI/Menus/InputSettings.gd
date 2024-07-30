extends Control


@onready var input_button = preload("res://Scenes/Menus/InputMenu/InputButton.tscn")
@onready var action_list = $Panel/MarginContainer/VBoxContainer/ScrollContainer/ActionList
@onready var reset = $Panel/MarginContainer/VBoxContainer/Reset

@onready var button_click = $ButtonClick
@onready var button_hover = $ButtonHover


var is_remapping: bool = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"up" : "Move up",
	"down" : "Move down",
	"left" : "Move left",
	"right" : "Move right",
	"jump" : "Jump",
	"attack" : "Attack",
	"dash" : "Dash",
	"heal" : "Heal",
	"interact" : "Interact"
}


func _ready():
	Load_Key_Bindings_From_Settings()
	Create_Action_List()
	visibility_changed.connect(On_Visibility_Changed)
	reset.pressed.connect(On_Reset_Button_Pressed)
	Install_Sounds()

func Load_Key_Bindings_From_Settings():
	var key_bindings = ConfigFileHandler.Load_Key_Bindings()
	for action in key_bindings.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, key_bindings[action])
	

func Create_Action_List():
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(On_Input_Button_Pressed.bind(button, action))
	action_list.get_children()[0].grab_focus()


func On_Input_Button_Pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."
		

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			ConfigFileHandler.Save_Key_Binding(action_to_remap, event)
			Update_Action_List(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()


func Update_Action_List(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")


func On_Visibility_Changed():
	if visible:
		var buttons = action_list.get_children()
		var first_button: Button = buttons[0]
		first_button.grab_focus()
		
func On_Reset_Button_Pressed():
	InputMap.load_from_project_settings()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			ConfigFileHandler.Save_Key_Binding(action, events[0])
	Create_Action_List()
	action_list.get_children()[0].grab_focus()
	
func Install_Sounds():
	var buttons = action_list.get_children()
	for button in buttons:
		button.focus_entered.connect(Play_Hover_Sound)
		button.pressed.connect(Play_Click_Sound)
		
func Play_Hover_Sound():
	button_hover.play()
	
func Play_Click_Sound():
	button_click.pitch_scale = randf_range(0.95, 1.05)
	button_click.play()

