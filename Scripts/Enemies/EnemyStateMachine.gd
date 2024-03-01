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
#this is where knockback is gonna go
@export var ledge_detector: RayCast2D

@export_category("Movement")
@export var movement_speed: float
var movement_direction: Vector2

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
	
	current_state = idle
	current_state.Enter(self)
	
func _process(delta):
	current_state.Update(self, delta)
	
func _physics_process(delta):
	current_state.Physics_Update(self, delta)
	
func Flip():
	pass

func Switch_State(new_state: EnemyBaseState):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func Move_Horizontally():
	if !is_being_knocked_back:
		CB2D.velocity.x = movement_direction.x * movement_speed
