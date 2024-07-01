extends CharacterBody2D

@onready var animator = $AnimationPlayer

# make the pickaxe travel in a parabola


var start_x: float
var end_x: float



func _ready():
	animator.play("falling")

func _physics_process(delta):
	move_and_slide()
