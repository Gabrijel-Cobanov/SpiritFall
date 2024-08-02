extends Node2D

@onready var spawn_player_timer = $SpawnPlayerTimer
@onready var spawn_stone = $SpawnStone
var hub_scene_path: String = "res://Scenes/Levels/HubWorld.tscn"
@onready var audio_stream_player_2d = $Environment/AudioStreamPlayer2D
@onready var mine_exit_area = $"Environment/Mine Exit/The top of the mine entrance/MineExitArea"

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.play()
	spawn_player_timer.timeout.connect(func(): spawn_stone.Activate_Stone())
	mine_exit_area.body_entered.connect(Complete_Level)

func Complete_Level(body: CharacterBody2D):
	print("Player entered")
	var thread = Thread.new()
	thread.start(Save_Progress, 1)
	thread.wait_to_finish()
	SceneTransitionManager.Transition_To_Scene(hub_scene_path)	
	
func Save_Progress():
	var game_data = SaveSystem.get_var("save_file_1")
	game_data.unlocked_level_ids[2] = 1
	SaveSystem.set_var("save_file_1", game_data)
	SaveSystem.save()
