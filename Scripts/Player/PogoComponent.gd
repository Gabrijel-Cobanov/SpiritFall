class_name PogoComponent extends Node2D

@onready var CB2D = $".."
@onready var attack_component = $"../AttackComponent"

var pogo_velocity: int = -250

func _ready():
	attack_component.should_pogo.connect(Pogo)

func Pogo():
	CB2D.velocity.y = 0
	CB2D.velocity.y += pogo_velocity
	
