extends StaticBody2D

@onready var animator = $AnimationPlayer
@onready var player_detector = $PlayerDetector
@onready var reform_timer = $ReformTimer
@onready var collision_shape_2d = $CollisionShape2D

@export var shown_after_boss_dies: bool = false


func _ready():
	if shown_after_boss_dies:
		animator.play("falling_apart")
	else:
		animator.play("idle")
	player_detector.body_entered.connect(Set_Off_Platform)
	GlobalSignalBus.show_platforms.connect(On_Boss_Death)
	


func Set_Off_Platform(body):
	animator.play("falling_apart")
	await animator.animation_finished
	
	reform_timer.start()
	await reform_timer.timeout
	
	animator.play("reforming")
	await  animator.animation_finished
	
	animator.play("idle")
	await  animator.animation_finished
	
func On_Boss_Death():
	animator.play("reforming")
	await  animator.animation_finished
	collision_shape_2d.disabled = false
	
