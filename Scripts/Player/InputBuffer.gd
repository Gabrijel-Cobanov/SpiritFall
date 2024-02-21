extends Node
class_name InputBuffer

var buffer: Array[String] = []
var buffer_time: float

func _ready():
	buffer_time = 0.1

func _process(delta):
	buffer_time -= delta
	if buffer_time <= 0:
		buffer.clear()
		buffer_time = 0.1

	if Input.is_action_pressed("attack"):
		buffer.append("attack")
	if Input.is_action_pressed("dash"):
		buffer.append("dash")
	if Input.is_action_pressed("jump"):
		buffer.append("jump")

func Get_Last_Input_Action() -> String:
	var result = ""
	if buffer.size() != 0:
		result = buffer.back()
		buffer.clear()
	return result
