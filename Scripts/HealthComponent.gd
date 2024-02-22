extends Node2D
class_name Health_Component

signal taken_damage
signal died

@export var max_health: int = 5
var current_health: int
var can_take_damage: bool = true
#length of the player attack animation
var can_take_damage_counter: float = 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health

func Take_Damage(damage: int):
	if can_take_damage:
		taken_damage.emit()
		current_health -= damage
		can_take_damage = false
		if current_health <= 0:
			died.emit()

func _physics_process(delta):
	if !can_take_damage:
		can_take_damage_counter -= delta
		if can_take_damage_counter <= 0:
			can_take_damage = true
			can_take_damage_counter = 0.3
