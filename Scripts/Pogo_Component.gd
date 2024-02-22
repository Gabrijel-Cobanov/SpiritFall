extends Node2D
class_name Pogo_Component

@export var down_hitbox: Area2D
@export var group: String = ""
@export var pogo_force: float = 200
@export var CB2D: CharacterBody2D

func _ready():
	if down_hitbox:
		down_hitbox.body_entered.connect(Pogo)

func Pogo(body):
	if(body.is_in_group(group)):
		CB2D.velocity.y = -pogo_force
		print("Pogo is being called")
	
