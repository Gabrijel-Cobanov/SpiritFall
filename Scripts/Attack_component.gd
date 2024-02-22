extends Node2D
class_name Attack_Component

@export var CB2D: CharacterBody2D
@export var group: String = ""
@export var damage: int = 1
@export var deal_knockback: int = 100
@export var up: Area2D
@export var down: Area2D
@export var right: Area2D
@export var on_contact: Area2D

var knockback_direction: Vector2

func _ready():
	if up:
		up.body_entered.connect(Attack_Up)
	if down:
		down.body_entered.connect(Attack_Down)
	if right:
		right.body_entered.connect(Attack)
	if on_contact:
		on_contact.body_entered.connect(On_Contact)

func Attack(body):
	if(body.is_in_group(group)):
		print("Currently hitting " + group)
		print("On the side")
		Deal_Damage(body)
		Deal_KnockBack(body)

func Attack_Up(body):
	if(body.is_in_group(group)):
		print("Currently hitting " + group)
		print("Upwards")
		Deal_Damage(body)

func Attack_Down(body):
	if(body.is_in_group(group)):
		print("Currently hitting " + group)
		print("Below")
		Deal_Damage(body)
	
func On_Contact(body):
	if(body.is_in_group(group)):
		Deal_Damage(body)
		Deal_KnockBack(body)

func Deal_Damage(body):
	var health: Health_Component = body.get_child(0)
	health.Take_Damage(damage)
	
func Deal_KnockBack(body):
	var enemy: KnockBack_component = body.get_child(1)
	var x = body.position.x - CB2D.position.x
	var y = body.position.y - CB2D.position.y
	var kb_direction = Vector2(x, y).normalized() * deal_knockback
	enemy.knockBack = kb_direction
	enemy.should_apply_knockback = true
