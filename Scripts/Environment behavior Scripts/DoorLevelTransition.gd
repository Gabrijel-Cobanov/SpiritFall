extends Node2D
class_name Door1

@export var door_num: int = 0

@onready var door_1_active = $"../Doors_visuals/Door1Active"
@onready var door_2_active = $"../Doors_visuals/Door2Active"
@onready var door_3_active = $"../Doors_visuals/Door3Active"

@onready var enter_level_pointer_1 = $Door1/EnterLevelPointer
@onready var enter_level_pointer_2 = $Door2/EnterLevelPointer

@onready var door_1_area2D = $Door1
@onready var door_2_area2D = $Door2

var path_to_level_one: String = "res://Scenes/Levels/LevelOne.tscn"
var path_to_level_two: String = "res://Scenes/Levels/LevelTwo.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_data = SaveSystem.get_var("save_file_1")
	
	var level_one_unlocked = game_data.unlocked_level_ids[0]
	var level_two_unlocked = game_data.unlocked_level_ids[1]
	
	if level_one_unlocked:
		door_1_active.visible = true
	if level_two_unlocked:
		door_2_active.visible = true
	
	if level_one_unlocked:
		door_1_area2D.body_entered.connect(func(body): enter_level_pointer_1.visible = true)
		door_1_area2D.body_exited.connect(func(body): enter_level_pointer_1.visible = false)
		
	if level_two_unlocked:
		door_2_area2D.body_entered.connect(func(body): enter_level_pointer_2.visible = true)
		door_2_area2D.body_exited.connect(func(body): enter_level_pointer_2.visible = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if  enter_level_pointer_1.visible and Input.is_action_just_pressed("interact"):
		SceneTransitionManager.Transition_To_Scene(path_to_level_one)
	
	elif  enter_level_pointer_2.visible and Input.is_action_just_pressed("interact"):
		SceneTransitionManager.Transition_To_Scene(path_to_level_two)
