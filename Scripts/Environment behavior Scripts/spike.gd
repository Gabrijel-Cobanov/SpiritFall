class_name Spike extends Node2D

@onready var damage_area_2d: Area2D = $Area2D

@export var player_on_left_area_check: Area2D
@export var player_on_right_area_check: Area2D

@export var marker_left: Marker2D
@export var marker_right: Marker2D
var current_marker: Marker2D

var knockback_to_player: float = -450

const dmg: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	damage_area_2d.body_entered.connect(Hurt_Player)
	damage_area_2d.body_entered.connect(Kill_Enemy)
	player_on_left_area_check.body_entered.connect(func(body): current_marker = marker_left)
	player_on_right_area_check.body_entered.connect(func(body): current_marker = marker_right)
	
func Hurt_Player(body: CharacterBody2D):
	if body.is_in_group("Player"):
		var health: HealthComponent = body.get_child(0)
		health.Take_Damage(dmg)
		body.velocity.y = knockback_to_player
		var hit_duration = 0.4
		var time_scale = 0.08
		Engine.time_scale = time_scale
		await get_tree().create_timer(hit_duration * time_scale).timeout
		Engine.time_scale = 1.0
		body.global_position = current_marker.global_position
		body.velocity.y = 0
	
func Kill_Enemy(body: CharacterBody2D):
	if body.is_in_group("enemies"):
		var health: HealthComponent = body.get_child(0)
		health.Take_Damage(health.current_health)

	
	
