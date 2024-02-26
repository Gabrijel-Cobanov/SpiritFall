extends Node
class_name VelocityController

#nodes
@export var CB2D: CharacterBody2D

#movement variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_direction: Vector2 = Vector2.ZERO
@export var movement_velocity: float = 80
@export var jump_velocity: float = 300

#flags
var is_being_knocked_back: bool
var should_apply_gravity: bool

#knockback variables
var knockback_time: float = 0.3

func _ready():
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func Take_Knockback(direction: Vector2):
	pass
	
func Move(direction: Vector2):
	pass

func Jump():
	pass
