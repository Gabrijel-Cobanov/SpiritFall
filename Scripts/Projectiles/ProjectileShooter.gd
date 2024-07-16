extends Node2D

var target_position: Vector2
const PICKAXE = preload("res://Scenes/Projectiles/Pickaxe.tscn")

func Shoot_Arc():
	var pickaxe = PICKAXE.instantiate()
	pickaxe.velocity = Vector2(1, 1)
	
	pickaxe.global_position = global_position
	get_parent().add_child(pickaxe)
	
