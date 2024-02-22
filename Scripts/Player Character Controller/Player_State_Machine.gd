extends Node
class_name Player_State_Machine

@onready var animation_player = $"../AnimationPlayer"
@onready var the_spirit = $".."
@onready var sprite_2d = $"../Sprite2D"

@onready var health_component = $"../Health_Component"


#states
@export var idle: Player_Idle
@export var run: Player_Run
@export var jump_start: Player_Jump_Start
@export var jump_middle: Player_Jump_Middle
@export var jump_end: Player_Jump_End
@export var swing1: Player_Swing_1
@export var swing2: Player_Swing_2
@export var swing3: Player_Swing_3
@export var hurt: Player_Hurt
@export var death: Player_Death
@export var dash: Player_Dash
var current_state: Player_Base_State

#flags
var is_facing_right: bool = true
var is_jumping: bool = false
var is_grounded: bool = true
var is_moving: bool = false
var is_dashing: bool = false
var is_attacking: bool = false
var should_attack: bool = false
var should_apply_gravity: bool = true
var can_move: bool = true
var has_died: bool = false

#movement variables
var speed = 100.0
var jump_slow_speed = 75
const JUMP_VELOCITY = -200.0
const DASH_VELOCITY = 200
var direction_h: float
var direction_v: float
var last_moved_direction_h: float
var gravity = 400

#combat
var damage: int = 1
var self_knockback: float = 100
var deal_knockback: float = 200
var pogo_force: float = 140

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = idle
	current_state.Enter(self)
	
	health_component.connect('taken_damage', On_Taken_Damage)
	health_component.connect('died', On_Death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state.Update(self, delta)
	is_grounded = the_spirit.is_on_floor()
	
	direction_h = Input.get_axis("move_left", "move_right")
	if direction_h != 0:
		last_moved_direction_h = direction_h
	direction_v = Input.get_axis("move_down", "move_up")
	
	# Handling input
	if not the_spirit.is_on_floor() and should_apply_gravity:
		the_spirit.velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_grounded:
		is_jumping = true;
	if Input.is_action_just_pressed("attack") and !is_dashing:
		is_attacking = true
	if Input.is_action_just_pressed("dodge") and !is_attacking:
		is_dashing = true
		
	if direction_h:
		is_moving = true
	else:
		is_moving = false
	Flip()
	
func _physics_process(delta):
	current_state.Pysics_Update(self, delta)
	the_spirit.move_and_slide()
	

func SwitchState(new_state: Player_Base_State):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func Flip():
	if is_facing_right and direction_h < 0:
		get_parent().scale.x *= -1
		is_facing_right = false
	elif !is_facing_right and direction_h > 0:
		get_parent().scale.x *= -1
		is_facing_right = true
		
func Move_Player(movement_speed: float):
	the_spirit.velocity.x = direction_h * movement_speed

func Lunge_Player():
	the_spirit.velocity.x = move_toward(the_spirit.velocity.x, 0, 3)
	
func Dash():
	the_spirit.velocity.x = last_moved_direction_h * DASH_VELOCITY
	the_spirit.velocity.y = 0
	
func Jump():
	the_spirit.velocity.y = JUMP_VELOCITY
	
func On_Taken_Damage():
	SwitchState(hurt)
	
func On_Death():
	has_died = true
