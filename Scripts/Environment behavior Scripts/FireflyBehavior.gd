extends Sprite2D

var floating_speed: float
const MAX_FLOAT: float = 1.3

var starting_position: Vector2
var current_position: Vector2

var floating_direction: Vector2
var floating_up: bool

func _ready():
	starting_position = global_position
	current_position = starting_position
	var direction = randi()
	if direction % 2 == 0:
		floating_direction = Vector2.UP
		floating_up = true
	else:
		floating_direction = Vector2.DOWN
		floating_up = false
	floating_speed = randf()/10
	

func _physics_process(delta):
	Float_Up_And_Down()


func Float_Up_And_Down():
	global_position += floating_direction * floating_speed
	current_position = global_position
	if current_position.distance_to(starting_position) > MAX_FLOAT:
		Switch_Floating_Direction()
		

func Switch_Floating_Direction():
	if floating_up:
		floating_direction = Vector2.DOWN
	else:
		floating_direction = Vector2.UP
	floating_up = !floating_up
