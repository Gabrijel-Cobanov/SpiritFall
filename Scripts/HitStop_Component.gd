extends Node2D
class_name Freeze_Frame_Component

#timescale 0.01, duration 0.4
func Apply_Freeze_Frame(timescale: float, duration: float):
	Engine.time_scale = timescale
	await(get_tree().create_timer(duration * timescale).timeout)
	Engine.time_scale = 1.0

