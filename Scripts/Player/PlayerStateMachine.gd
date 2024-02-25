extends Node
class_name PlayerStateMachine

#nodes
@export var CB2D: CharacterBody2D
@export var animator: AnimationPlayer
@export var input_buffer: InputBuffer
@export var coyote: Coyote
@onready var dash_cooldown: Timer = $"../Timers/DashCooldown"
@onready var attack_combo_cooldown: Timer = $"../Timers/AttackComboCooldown"


#movement variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_input: Vector2 = Vector2.ZERO
const MOVEMENT_SPEED: float = 100
const JUMP_VELOCITY: float = -320
const MAX_FALL_VELOCITY: float = 300
const MAX_HEIGHT_TIME: float = 0.3
const DASH_VELOCITY: float = 210

#flags
var is_facing_right: bool = true
var should_apply_gravity: bool = true
var is_attacking: bool = false
var can_attack: bool = true
var can_dash: bool = true

#states
var idle: PlayerIdle
var run: PlayerRun
var dash: PlayerDash
var jump_start: PlayerJumpStart
var jump_middle: PlayerJumpMiddle
var jump_end: PlayerJumpEnd
var hurt: PlayerHurt
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
	death = PlayerDeath.new()
	swing1 = PlayerSwing1.new()
	swing2 = PlayerSwing2.new()
	
	dash_cooldown.connect("timeout", Reset_Dash_Cooldown)
	attack_combo_cooldown.connect("timeout", Reset_Attack_Cooldown)
	
	current_state = idle
	current_state.Enter(self)

func _process(delta):
	movement_input = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	Flip()
	current_state.Update(self, delta)

func _physics_process(delta):
	if not CB2D.is_on_floor() and should_apply_gravity:
		CB2D.velocity.y += gravity * delta
	
	current_state.Physics_Update(self, delta)
	CB2D.move_and_slide()

# Biggies Little helpers

func Flip():
	if is_facing_right and movement_input.x < 0:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	elif !is_facing_right and movement_input.x > 0:
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
