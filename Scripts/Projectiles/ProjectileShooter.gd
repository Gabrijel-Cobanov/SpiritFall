extends Node2D

@export var arcing: bool = true
var arc_curve = 100

@export var end_marker: Marker2D
const PICKAXE = preload("res://Scenes/Projectiles/Pickaxe.tscn")

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		Shoot()

func Shoot():
	var start_pos = end_marker.global_position
	var direction = 1
	var target_pos = Vector2(start_pos.x, start_pos.y) - global_position
	
	var pickaxe = PICKAXE.instantiate()
	pickaxe.target_position = target_pos
	
	pickaxe.global_position = global_position
	get_parent().add_child(pickaxe)
	
