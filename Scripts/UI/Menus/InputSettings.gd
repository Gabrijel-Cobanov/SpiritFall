extends Control


@onready var input_button = preload("res://Scenes/Menus/InputMenu/InputButton.tscn")
@onready var action_list = $Panel/MarginContainer/VBoxContainer/ScrollContainer/ActionList


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
	Create_Action_List()
	visibility_changed.connect(On_Visibility_Changed)
	
	

func Create_Action_List():
	InputMap.load_from_project_settings()
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
		
func On_Visibility_Changed():
	if visible:
		var buttons = action_list.get_children()
		var first_button: Button = buttons[0]
		first_button.grab_focus()


