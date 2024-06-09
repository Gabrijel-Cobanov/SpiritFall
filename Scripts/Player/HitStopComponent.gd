extends Node2D
class_name HitStopComponent

@onready var attack_component = $"../AttackComponent"

var time_scale = 0.08
var duration = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_component.hit_something.connect(Freeze_Frame)
	

func Freeze_Frame():
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1.0
	
func Freeze_Frame_Taking_Damage():
	var hit_duration = 0.4
	Engine.time_scale = time_scale
	await get_tree().create_timer(hit_duration * time_scale).timeout
	Engine.time_scale = 1.0
	

