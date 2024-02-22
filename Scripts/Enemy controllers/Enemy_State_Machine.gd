extends Node
class_name Enemy_State_Machine

# The next thing to do is the white flash to indicate taking damage and to
# adjust the attack animation to have even more of a telegraph so it is more easily dodged.
# Ofcourse, that will come after implementing the pursue state


#add a timer between attacks, when the robot just attacks it is ridicolous
@onready var CB2D = $".."
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var health_component: Health_Component = $"../Health_Component"
@onready var attack_timer: Timer = $"../Timer"
@onready var ledge_check = $"../LedgeCheck"


@export var enemy_name: String

# states
@export var idle: Enemy_Base_State
@export var attack: Enemy_Base_State
@export var pursue: Enemy_Base_State
@export var death: Enemy_Base_State
var current_state: Enemy_Base_State

#flags
var is_facing_right: bool = true
var is_attacking: bool = false
var can_attack: bool = true
var is_on_ledge: bool = false
var is_inline_with_player: bool = false

var player: CharacterBody2D

#movement
var gravity: float = 400
var speed: float = 15

#combat
var pursue_range: float = 100
var attack_range: float = 45

# ready
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	attack_timer.connect("timeout", On_Attack_Timer_Timeout)
	health_component.connect("died", On_Died)
	
	current_state = idle
	current_state.Enter(self)

# update functions
func _process(delta):
	is_on_ledge = !ledge_check.is_colliding()
	is_inline_with_player = abs(Get_Distance_To_Player_Y()) >= 0 and abs(Get_Distance_To_Player_Y()) <= 2
	Flip()
	current_state.Update(self, delta)
	
func _physics_process(delta):
	Apply_Gravity()
	current_state.Pysics_Update(self, delta)
	CB2D.move_and_slide()

# Biggies little helpers
func Flip():
	if player.position.x - CB2D.position.x < 0 and is_facing_right and is_inline_with_player:
		CB2D.scale.x *= -1
		is_facing_right = !is_facing_right
	elif player.position.x - CB2D.position.x > 0 and !is_facing_right and is_inline_with_player:
		CB2D.scale.x *= -1
		is_facing_right = !is_facing_right
		
func Get_Distance_To_Player_X(): 
	return abs(player.position.x - CB2D.position.x)
	
func Get_Distance_To_Player_Y(): 
	return abs(player.position.y - CB2D.position.y)
	
func SwitchState(new_state: Enemy_Base_State):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func Move_Enemy():
	if is_facing_right:
		CB2D.velocity.x = move_toward(CB2D.velocity.x, speed, 10)
		if is_on_ledge:
			SwitchState(idle)
	elif !is_facing_right:
		CB2D.velocity.x = move_toward(CB2D.velocity.x, -speed, 10)
		if is_on_ledge:
			SwitchState(idle)
	CB2D.move_and_slide()
	
func Apply_Gravity():
	CB2D.velocity.y += gravity
	CB2D.move_and_slide()
	
func On_Attack_Timer_Timeout():
	can_attack = true
	
func On_Died():
	SwitchState(death)
