extends Area2D


@onready var enter_level_pointer = $EnterLevelPointer
var path_to_level: String = "res://Scenes/Levels/"
@export var level_name: String

var player_near_door: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(func(body): enter_level_pointer.visible = true)
	body_exited.connect(func(body): enter_level_pointer.visible = false)
	
	player_near_door = enter_level_pointer.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_near_door = enter_level_pointer.visible
	if player_near_door and Input.is_action_just_pressed("interact"):
		SceneTransitionManager.Transition_To_Scene(path_to_level + level_name)
