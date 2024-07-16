extends CharacterBody2D


const PICKAXE = preload("res://Scenes/Projectiles/Pickaxe.tscn")

func Shoot_Arc():
	var pickaxe = PICKAXE.instantiate()
	pickaxe.source = self
	get_parent().add_child(pickaxe)
	
