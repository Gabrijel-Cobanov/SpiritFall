extends Node2D
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

signal hit_something
signal hit_something_at_pos(position: Vector2)
signal should_pogo

func _ready():
	if up: 
		up.body_entered.connect(Attack)
	if down: 
		down.body_entered.connect(Attack)
		down.body_entered.connect(func(body): should_pogo.emit())
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
	if body.is_in_group("enemies") or body.is_in_group("Player"):
		body.velocity = direction
	hit_something.emit()
	GlobalSignalBus.something_got_hit_at_pos.emit(body.position)
	
func _process(delta):
	if contact and contact.has_overlapping_bodies():
		var body = contact.get_overlapping_bodies()[0]
		Attack(body)
	
