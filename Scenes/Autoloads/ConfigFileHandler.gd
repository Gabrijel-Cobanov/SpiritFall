extends Node


var config = ConfigFile.new()
const SETTINGS_FILE_PATH: String = "user://settings.ini"

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "left", "A")
		config.set_value("keybinding", "right", "D")
		config.set_value("keybinding", "up", "W")
		config.set_value("keybinding", "down", "S")
		config.set_value("keybinding", "attack", "K")
		config.set_value("keybinding", "jump", "J")
		config.set_value("keybinding", "dash", "L")
		config.set_value("keybinding", "interact", "E")
		config.set_value("keybinding", "heal", "H")
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
		
func Save_Key_Binding(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouse:
		event_str = "mouse_" + str(event.button_index)
		
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)
	

func Load_Key_Bindings():
	var key_bindings = {}
	var keys = config.get_section_keys("keybinding")
	
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinding", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
			
		key_bindings[key] = input_event
	return key_bindings




