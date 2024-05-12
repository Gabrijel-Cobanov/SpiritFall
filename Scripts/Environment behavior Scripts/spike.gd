class_name Spike extends Node2D

@onready var damage_area_2d: Area2D = $Area2D

@export var player_on_left_area_check: Area2D
@export var player_on_right_area_check: Area2D

@export var marker_left: Marker2D
@export var marker_right: Marker2D
var current_marker: Marker2D

const dmg: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	damage_area_2d.body_entered.connect(Hurt_Player)
	player_on_left_area_check.body_entered.connect(func(body): current_marker = marker_left)
	player_on_right_area_check.body_entered.connect(func(body): current_marker = marker_right)
	
func Hurt_Player(body: CharacterBody2D):
	var health: HealthComponent = body.get_child(0)
	health.Take_Damage(dmg)
	body.global_position = current_marker.global_position
