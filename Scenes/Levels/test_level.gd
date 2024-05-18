extends Node2D

@onready var spawn_stone = $SpawnStone
@onready var spawn_player_timer = $SpawnPlayerTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player_timer.timeout.connect(func(): spawn_stone.Activate_Stone())
