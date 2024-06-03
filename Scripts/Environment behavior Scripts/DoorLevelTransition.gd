extends Area2D
class_name Door1

@onready var door_1_active = $"../../Doors_visuals/Door1Active"
@onready var door_2_active = $"../../Doors_visuals/Door2Active"
@onready var enter_level_pointer = $EnterLevelPointer
var path_to_level: String = "res://Scenes/Levels/LevelOne.tscn"

var player_near_door: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_data = SaveSystem.get_var("save_file_1")
	
	var level_one_unlocked = game_data.unlocked_level_ids[0]
	var level_two_unlocked = game_data.unlocked_level_ids[1]
	
	if level_one_unlocked:
		door_1_active.visible = true
	if level_two_unlocked:
		door_2_active.visible = true
	
	
	body_entered.connect(func(body): enter_level_pointer.visible = true)
	body_exited.connect(func(body): enter_level_pointer.visible = false)
	
	player_near_door = enter_level_pointer.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_near_door = enter_level_pointer.visible
	if player_near_door and Input.is_action_just_pressed("interact"):
		SceneTransitionManager.Transition_To_Scene(path_to_level)
