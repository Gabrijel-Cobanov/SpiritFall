extends Node
class_name Coyote

@export var CB2D: CharacterBody2D
@export var coyote_time: float = 0.2
var coyote_timer: float

func _ready():
	coyote_timer = coyote_time

func _physics_process(delta):
	if !CB2D.is_on_floor():
		coyote_timer -= delta
	else:
		coyote_timer = coyote_time
