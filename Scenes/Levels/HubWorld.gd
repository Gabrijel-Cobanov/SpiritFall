extends Node2D

@onready var thanks_for_playing = $ThanksForPlaying


# Called when the node enters the scene tree for the first time.
func _ready():
	var game_data = SaveSystem.get_var("save_file_1")
	thanks_for_playing.visible = game_data.boss_defeated


