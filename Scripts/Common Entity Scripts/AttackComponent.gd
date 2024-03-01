extends Node
class_name AttackComponent

@export var CB2D: CharacterBody2D

@export_category("Areas")
@export var up: Area2D
@export var down: Area2D
@export var side: Area2D
@export var contact: Area2D

@export_category("Combat")
@export var dmg: int
@export var knockback_dealt: int

func _ready():
	if up: 
		up.body_entered.connect(Attack)
	if down: 
		down.body_entered.connect(Attack)
	if side:
		side.body_entered.connect(Attack)
	if contact:
		contact.body_entered.connect(Attack)
	pass
	
func Attack(body: CharacterBody2D):
	var health: HealthComponent = body.get_child(0)
	health.Take_Damage(dmg)
	var direction: Vector2 = body.position - CB2D.position
	direction = direction.normalized() * knockback_dealt
	body.velocity = direction
	
