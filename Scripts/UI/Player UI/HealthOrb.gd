extends Node2D
class_name HealthOrb

@onready var animator = $AnimationPlayer

func Play_Active():
	animator.play("active")

func Play_Hurt():
	animator.play("hurt")
	
func Play_Healing():
	animator.play("healing")
