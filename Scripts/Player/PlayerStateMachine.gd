extends Node
class_name PlayerStateMachine

#nodes
@export var CB2D: CharacterBody2D
@onready var input_buffer: InputBuffer = $"../InputBuffer"

#movement variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_input: Vector2 = Vector2.ZERO
const MOVEMENT_SPEED: float = 200.0
const JUMP_VELOCITY: float = -300.0
const MAX_HEIGHT_TIME: float = 0.3

#flags
var is_facing_right: bool = true

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
	
	current_state = idle
	current_state.Enter(self)

func _process(delta):
	movement_input = Input.get_vector("left", "right", "up", "down").normalized()
	Flip()
	current_state.Update(self, delta)

func _physics_process(delta):
	if not CB2D.is_on_floor():
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

