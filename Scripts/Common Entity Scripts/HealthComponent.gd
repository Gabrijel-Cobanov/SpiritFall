extends Node
class_name HealthComponent

@export var max_health: int
var current_health: int

signal hurt
signal dead

func _ready():
	current_health = max_health
	
func Take_Damage(dmg: int):
	hurt.emit()
	current_health -= dmg
	if current_health <= 0:
		dead.emit()

func Heal(hp: int):
	if current_health + hp <= max_health:
		current_health += hp
	else:
		current_health = max_health
