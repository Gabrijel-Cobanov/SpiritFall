extends Camera2D
class_name ShakeCam

var shake_strength: float = 0.62
var shake_fade: float = 10

var current_shake: float = 0


func _ready():
	pass


func _process(delta):
	if current_shake > 0:
		current_shake = lerpf(current_shake, 0, delta * shake_fade)
		offset = Random_Offset()

func Apply_Shake():
	current_shake = shake_strength


func Random_Offset() -> Vector2:
	return Vector2(randf_range(-current_shake, current_shake), randf_range(-current_shake, current_shake) -10)
