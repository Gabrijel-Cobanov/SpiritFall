extends Node2D
class_name HealthComponent

@export var hitflash_animator: AnimationPlayer
@export var max_health: int = 10
@export var heal_ammount: int = 1
var current_health: int

var can_take_damage: bool = true
var can_heal: bool = true

signal hurt(int)
signal heal(int)
signal health_restored
signal dead

func _ready():
	current_health = max_health
	
func Take_Damage(dmg: int):
	if can_take_damage:
		if hitflash_animator:
			hitflash_animator.play("hitflash")
		hurt.emit(dmg)
		current_health -= dmg
		if current_health <= 0:
			dead.emit()

func Heal():
	if can_heal:
		if current_health + heal_ammount <= max_health:
			current_health += heal_ammount
		else:
			current_health = max_health
		heal.emit(heal_ammount)
		
func Heal_To_Full_Health():
	current_health = max_health
	health_restored.emit()
