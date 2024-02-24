extends Node
class_name InputBuffer

var buffer: Array[String] = []
@export var buffer_time: float = 0.2
var attack_buffer_time: float = 0.21
var buffer_time_counter: float

func _ready():
	buffer_time_counter = buffer_time

func _physics_process(delta):
	if buffer.size() != 0:
		buffer_time_counter -= delta
		
	if buffer_time_counter <= 0:
		buffer.clear()
		buffer_time_counter = buffer_time

	if Input.is_action_just_pressed("attack"):
		buffer.append("attack")
		buffer_time_counter = buffer_time
	if Input.is_action_just_pressed("dash"):
		buffer.append("dash")
		buffer_time_counter = buffer_time
	if Input.is_action_just_pressed("jump"):
		buffer.append("jump")
		buffer_time_counter = buffer_time

func Get_Last_Input_Action() -> String:
	var result = ""
	if buffer.size() != 0 and buffer_time_counter != 0:
		result = buffer.back()
	return result
