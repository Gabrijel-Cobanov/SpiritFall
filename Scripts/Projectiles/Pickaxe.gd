extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player.play("falling")
	
func _physics_process(delta):
	move_and_slide()

