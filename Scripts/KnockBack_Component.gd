extends Node2D
class_name KnockBack_component

@export var CB2D: CharacterBody2D
var knockBack: Vector2
var knockBackDuration: float = 0.01
var timer: float
var should_apply_knockback: bool = false

func _ready():
	timer = knockBackDuration
	
func _process(delta):
	if should_apply_knockback:
		CB2D.velocity = knockBack
		timer -= delta
		if timer <= 0:
			should_apply_knockback = false
			timer = knockBackDuration
