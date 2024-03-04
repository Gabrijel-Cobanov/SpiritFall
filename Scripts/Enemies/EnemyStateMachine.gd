extends Node
class_name EnemyStateMachine

@export var enemy_name: String

@export_category("Nodes")
@export var CB2D: CharacterBody2D
@export var health: HealthComponent
@export var pursue_area: Area2D
@export var attack_area: Area2D
@export var attack_timer: Timer
@export var knockback_timer: Timer
@export var ledge_detector: RayCast2D

@export_category("Movement")
@export var movement_speed: float
var movement_direction: Vector2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#flags
var is_facing_right: bool = true
var can_attack: bool = true
var is_being_knocked_back: bool = false

#states
var idle: EnemyIdleState
var move: EnemyMoveState
var attack: EnemyAttackState
var death: EnemyDeathState

var current_state: EnemyBaseState

func _ready():
	idle = EnemyIdleState.new()
	move = EnemyMoveState.new()
	attack = EnemyAttackState.new()
	death = EnemyDeathState.new()
	
	
	health.hurt.connect(On_Hurt)
	knockback_timer.timeout.connect(Reset_Velocity_X)
	
	current_state = idle
	current_state.Enter(self)
	
func _process(delta):
	current_state.Update(self, delta)
	
func _physics_process(delta):
	if !CB2D.is_on_floor():
		CB2D.velocity.y += gravity * delta
	current_state.Physics_Update(self, delta)
	
	CB2D.move_and_slide()
	
func Flip():
	pass

func Switch_State(new_state: EnemyBaseState):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func Move_Horizontally():
	if !is_being_knocked_back:
		CB2D.velocity.x = movement_direction.x * movement_speed
		
func Reset_Velocity_X():
	CB2D.velocity.x = 0
	
func On_Hurt():
	knockback_timer.start()
	#flash white but we'll get to that
