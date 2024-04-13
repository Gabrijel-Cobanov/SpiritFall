extends Node2D
class_name HealthOrb

@onready var animator = $AnimationPlayer

func play_active():
	animator.play("active")

func play_hurt():
	animator.play("hurt")
	
func play_healing():
	animator.play("healing")
