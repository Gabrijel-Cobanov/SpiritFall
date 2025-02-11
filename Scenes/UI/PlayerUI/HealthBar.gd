extends Node2D
class_name HealthBar

var player_CB2D: CharacterBody2D
var player_health_component: HealthComponent
var player_attack_component: AttackComponent
var health_orbs = []
var current_health_orb: HealthOrb
var current_orb_index: int
@onready var mana_indicator = $ManaIndicator
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	await GlobalSignalBus.player_spawned
	visible = true
	player_CB2D = get_tree().get_first_node_in_group("Player")
	health_orbs = get_tree().get_nodes_in_group("health_orbs")
	player_health_component = player_CB2D.get_child(0)
	player_attack_component = player_CB2D.get_child(1)
	
	player_health_component.connect("hurt", On_Damage_Taken)
	player_health_component.connect("heal", On_Heal)
	player_health_component.connect("health_restored", Heal_To_Full_Health)
	player_attack_component.connect("hit_something", mana_indicator.Increase_Mana)
	
	player_health_component.can_heal = false
	
	mana_indicator.mana_updated.connect(Check_Mana_Ammount)
	
	current_health_orb = health_orbs[-1]
	current_orb_index = len(health_orbs)-1
	current_health_orb.Play_Active()
	pass # Replace with function body.

func On_Damage_Taken(dmg: int):
	if current_orb_index >= 0:
		for i in range(current_orb_index, current_orb_index-dmg, -1):
			current_health_orb = health_orbs[i]
			current_health_orb.Play_Hurt()
		current_orb_index -= dmg
	if current_orb_index <= -1:
		return
	current_health_orb = health_orbs[current_orb_index]
	current_health_orb.Play_Active()

func On_Heal(hp_healed: int):
	if current_orb_index + hp_healed < len(health_orbs):
		for i in range(current_orb_index, current_orb_index+hp_healed):
			current_health_orb = health_orbs[i]
			current_health_orb.Play_Healing()
		current_orb_index += hp_healed
		current_health_orb = health_orbs[current_orb_index]
		current_health_orb.Play_Active()
	mana_indicator.Decrease_Mana()
	mana_indicator.Decrease_Mana()
	
func Heal_To_Full_Health():
	for i in range(current_orb_index, len(health_orbs)-1):
		current_health_orb = health_orbs[i]
		current_health_orb.Play_Healing()
	current_orb_index = len(health_orbs)-1
	current_health_orb = health_orbs[current_orb_index]
	current_health_orb.Play_Active()
	
func Check_Mana_Ammount(ammount: int):
	if ammount > 1:
		player_health_component.can_heal = true
	else:
		player_health_component.can_heal = false
