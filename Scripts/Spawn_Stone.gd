extends Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var player_spawn_position = $PlayerSpawnPosition

@export var camera_to_remove: Camera2D

var player_scene_path = "res://Scenes/Player/player.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("dormant")
	
func Activate_Stone():
	animation_player.play("waking")
	await animation_player.animation_finished
	animation_player.play("active")

func Spawn_Player():
	var player_scene = load(player_scene_path).instantiate()
	player_scene.position = player_spawn_position.global_position
	var camera_2D: Camera2D = Camera2D.new()
	get_parent().add_child(player_scene)
	player_scene.add_child(camera_2D)
	camera_2D.make_current()
	player_scene.velocity.y += -250
	get_parent().remove_child(camera_to_remove)
	GlobalSignalBus.player_spawned.emit()
