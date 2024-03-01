extends Node
class_name KnockbackComponent

@export var CB2D: CharacterBody2D

func Take_Knockback(direction: Vector2):
	CB2D.velocity = direction
