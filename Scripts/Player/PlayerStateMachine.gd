extends Node
class_name PlayerStateMachine

@export_category("Nodes")
@export var CB2D: CharacterBody2D
@export var animator: AnimationPlayer
@export var input_buffer: InputBuffer
@export var coyote: Coyote
@onready var dash_cooldown: Timer = $"../Timers/DashCooldown"
@onready var attack_combo_cooldown: Timer = $"../Timers/AttackComboCooldown"
@onready var hurt_cooldown = $"../Timers/HurtCooldown"
@onready var i_frames_animator = $"../Visuals/IFramesAnimationPlayer"
@onready var heal_cooldown = $"../Timers/HealCooldown"
@export var health: HealthComponent
@export var hit_stop: HitStopComponent

#movement variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_input: Vector2 = Vector2.ZERO
const MOVEMENT_SPEED: float = 75
const JUMP_VELOCITY: float = -300
const MAX_FALL_VELOCITY: float = 290
const MAX_HEIGHT_TIME: float = 0.35
const DASH_VELOCITY: float = 160

var combo_counter: int = 1
var max_combo_counter:int = 2

#flags
var is_facing_right: bool = true
var should_apply_gravity: bool = true
var is_attacking: bool = false
var can_attack: bool = true
var can_dash: bool = true
var can_heal: bool = true
var heal_is_pressed: bool = false

#states
var idle: PlayerIdle
var run: PlayerRun
var dash: PlayerDash
var jump_start: PlayerJumpStart
var jump_middle: PlayerJumpMiddle
var jump_end: PlayerJumpEnd
var hurt: PlayerHurt
var heal: PlayerHeal
var death: PlayerDeath
var swing1: PlayerSwing1
var swing2: PlayerSwing2

var current_state: PlayerBaseState

func _ready():
	idle =  PlayerIdle.new()
	run = PlayerRun.new()
	dash = PlayerDash.new()
	jump_start = PlayerJumpStart.new()
	jump_middle = PlayerJumpMiddle.new()
	jump_end = PlayerJumpEnd.new()
	hurt = PlayerHurt.new()
	heal = PlayerHeal.new()
	death = PlayerDeath.new()
	swing1 = PlayerSwing1.new()
	swing2 = PlayerSwing2.new()
	
	dash_cooldown.connect("timeout", Reset_Dash_Cooldown)
	attack_combo_cooldown.connect("timeout", Reset_Attack_Cooldown)
	hurt_cooldown.connect("timeout", Reset_Hurt_Cooldown)
	heal_cooldown.connect("timeout", func(): can_heal = true)
	health.hurt.connect(On_Hurt)
	health.dead.connect(On_Dead)
	
	current_state = idle
	current_state.Enter(self)

func _process(delta):
	movement_input = Input.get_vector("left", "right", "up", "down").normalized()
	heal_is_pressed = Input.is_action_pressed("heal")
	can_heal = health.can_heal
	if Input.is_action_just_pressed("attack") and can_attack:
		is_attacking = true
	if combo_counter >= max_combo_counter:
		can_attack = false
		combo_counter = 1
		attack_combo_cooldown.start()
	Flip()
	current_state.Update(self, delta)

func _physics_process(delta):
	if not CB2D.is_on_floor() and should_apply_gravity and CB2D.velocity.y <= MAX_FALL_VELOCITY:
		CB2D.velocity.y += gravity * delta
	
	current_state.Physics_Update(self, delta)
	CB2D.move_and_slide()

# Biggies Little helpers

func Flip():
	if is_facing_right and movement_input.x < 0 and current_state != dash and current_state != swing1 and current_state != swing2:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	elif !is_facing_right and movement_input.x > 0 and current_state != dash and current_state != swing1 and current_state != swing2:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	
func Switch_State(new_state: PlayerBaseState):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)

func Move_Player_Horizontally():
	CB2D.velocity.x = movement_input.x * MOVEMENT_SPEED
	
func Reset_Dash_Cooldown():
	can_dash = true
	
func Reset_Attack_Cooldown():
	can_attack = true
	
func Reset_Hurt_Cooldown():
	health.can_take_damage = true
	i_frames_animator.play("reset")
	
func On_Hurt(dmg: int):
	if health.can_take_damage:
		Switch_State(hurt)

func On_Dead():
	Switch_State(death)
