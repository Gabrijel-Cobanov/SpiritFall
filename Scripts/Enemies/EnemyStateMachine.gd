extends Node
class_name EnemyStateMachine

@export var enemy_name: String
var player_CB2D: CharacterBody2D
var enemy_active: bool = false

@export_category("Nodes")
@export var CB2D: CharacterBody2D
@export var health: HealthComponent
@export var pursue_area: Area2D
@export var attack_area: Area2D
@export var attack_timer: Timer
@export var knockback_timer: Timer
@export var ledge_detector: RayCast2D
@export var animator: AnimationPlayer

@export_category("Other Variables")
@export var movement_speed: float
@export var lunge_speed: float = 0
@export var death_anim_duration: float
@export var attack_anim_duration: float
var movement_direction: Vector2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_category("Sounds")
@export var step_sound: AudioStream
@export var taking_damage_sound: AudioStream
@export var attacking_sound: AudioStream
@export var death_sound: AudioStream

@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"

#flags
var is_facing_right: bool = true
var can_attack: bool = true
var should_attack: bool = false
var should_pursue: bool = false
var is_being_knocked_back: bool = false

#states
var idle: EnemyIdleState
var move: EnemyMoveState
var attack: EnemyAttackState
var death: EnemyDeathState

var current_state: EnemyBaseState

func _ready():
	await GlobalSignalBus.player_spawned
	enemy_active = true
	player_CB2D = get_tree().get_first_node_in_group("Player")
	
	idle = EnemyIdleState.new()
	move = EnemyMoveState.new()
	attack = EnemyAttackState.new()
	death = EnemyDeathState.new()
	
	health.hurt.connect(On_Hurt)
	health.dead.connect(On_Dead)
	knockback_timer.timeout.connect(Reset_Velocity_X)
	knockback_timer.timeout.connect(func(): is_being_knocked_back = false)
	if attack_timer: 
		attack_timer.timeout.connect(func(): can_attack = true)
	
	if pursue_area:
		pursue_area.body_entered.connect(func(body): should_pursue = true)
		pursue_area.body_exited.connect(func(body): should_pursue = false)
	
	if attack_area:
		attack_area.body_entered.connect(func(body): should_attack = true)
		attack_area.body_exited.connect(func(body): should_attack = false)
	
	current_state = idle
	current_state.Enter(self)
	
func _process(delta):
	if enemy_active:
		current_state.Update(self, delta)
		Flip()
	
func _physics_process(delta):
	if enemy_active:
		if !CB2D.is_on_floor():
			CB2D.velocity.y += gravity * delta
		current_state.Physics_Update(self, delta)
		movement_direction = get_movement_direction()
		CB2D.move_and_slide()
	
func Flip():
	if is_being_knocked_back:
		return
	if is_facing_right and CB2D.velocity.x < 0:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	elif !is_facing_right and CB2D.velocity.x > 0:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right

func Switch_State(new_state: EnemyBaseState):
	current_state.Exit(self)
	current_state = new_state
	new_state.Enter(self)
	
func get_movement_direction():
	return (player_CB2D.position-CB2D.position).normalized()
	
func Pursue():
	if !is_being_knocked_back:
		CB2D.velocity.x = movement_direction.x * movement_speed
		
func Wander(direction: int):
	if !is_being_knocked_back:
		CB2D.velocity.x = movement_speed * direction
		
func Reset_Velocity_X():
	CB2D.velocity.x = 0
	
func Lunge_Forward():
	if is_facing_right:
		CB2D.velocity.x = lunge_speed
	else:
		CB2D.velocity.x = -lunge_speed
	
func On_Hurt(dmg: int):
	is_being_knocked_back = true
	knockback_timer.start()
	
func On_Dead():
	Switch_State(death)
	
func Face_Player():
	var x = (player_CB2D.position-CB2D.position).x
	if x < 0 and is_facing_right:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
	elif x > 0 and !is_facing_right:
		get_parent().scale.x *= -1
		is_facing_right = !is_facing_right
		
func Play_Death_Sound():
	audio_stream_player_2d.stream = death_sound
	audio_stream_player_2d.play()
	
func Play_Step_Sound():
	audio_stream_player_2d.stream = step_sound
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.play()
	
func Play_Attack_Sound():
	audio_stream_player_2d.stream = attacking_sound
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.play()
	
func Play_Damage_Sound():
	audio_stream_player_2d.stream = taking_damage_sound
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.play()
	
	
	
