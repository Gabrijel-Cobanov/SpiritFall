extends Node2D
class_name BossStateMachine

@onready var CB2D: CharacterBody2D = $".."
@onready var health: HealthComponent = $"../HealthComponent"

@onready var idle = $BossIdle
@onready var move = $BossMove
@onready var flame_start = $BossFlameStart
@onready var flame_middle = $BossFlameMiddle
@onready var flame_end = $BossFlameEnd
@onready var spawn_walker = $BossSpawnWalker
@onready var swing = $BossSwing
@onready var death = $BossDeath

var current_state: BossState
@onready var animator = $"../Visuals/AnimationPlayer"
@onready var knockback_timer = $"../Timers/KnockbackTimer"
@onready var attack_timer = $"../Timers/AttackTimer"
@onready var idle_cooldown = $"../Timers/IdleCooldown"
@onready var pursue_area = $"../Areas/PursueArea"
@onready var attack_area = $"../Areas/AttackArea"

var player_CB2D: CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var num_of_attacks_done: int = 0

var is_active: bool = false
var is_facing_right: bool = true
var is_is_being_knocked_back: bool = false
var should_pursue_player: bool = false
var should_attack_player: bool = false
var can_attack_player: bool = true
var can_spawn_walker_bot: bool = false

#exports
@export var movement_speed: int = 3000

func _ready():
	await GlobalSignalBus.player_spawned
	is_active = true
	player_CB2D = get_tree().get_first_node_in_group("Player")
	
	health.hurt.connect(On_Hurt)
	
	knockback_timer.timeout.connect(func(): is_is_being_knocked_back = false)
	knockback_timer.timeout.connect(Reset_Velocity_X)
	
	attack_timer.timeout.connect(func(): can_attack_player = true)
	
	pursue_area.body_entered.connect(func(body: CharacterBody2D): should_pursue_player = true)
	pursue_area.body_exited.connect(func(body: CharacterBody2D): should_pursue_player = false)
	
	attack_area.body_entered.connect(func(body: CharacterBody2D): should_attack_player = true)
	attack_area.body_exited.connect(func(body: CharacterBody2D): should_attack_player = false)
	
	current_state = idle
	current_state.Enter(self)
	
func _process(delta):
	
	can_spawn_walker_bot = num_of_attacks_done % 5 == 0
	
	if is_active:
		Flip()
		current_state.Update(self)
	
func _physics_process(delta):
	if is_active:
		if not CB2D.is_on_floor():
			CB2D.velocity.y += gravity * delta
		if not is_is_being_knocked_back:
			CB2D.move_and_slide()
			
		current_state.Pyhsics_Update(self, delta)

func Flip():
	if is_is_being_knocked_back:
		return
	if is_facing_right and CB2D.velocity.x < 0:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	elif !is_facing_right and CB2D.velocity.x > 0:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right

func Switch_State(new_state: BossState):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func get_movement_direction():
	return (player_CB2D.position-CB2D.position).normalized()
	
func Move(delta: float):
	CB2D.velocity = movement_speed * get_movement_direction() * delta
	
func Reset_Velocity_X():
	CB2D.velocity.x = 0

func On_Hurt(dmg: int):
	is_is_being_knocked_back = true
	knockback_timer.start()

