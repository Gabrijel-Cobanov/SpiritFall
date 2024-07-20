extends StaticBody2D

@onready var animator = $AnimationPlayer
@onready var player_detector = $PlayerDetector
@onready var reform_timer = $ReformTimer


func _ready():
	animator.play("idle")
	player_detector.body_entered.connect(Set_Off_Platform)


func Set_Off_Platform(body):
	animator.play("falling_apart")
	await animator.animation_finished
	
	reform_timer.start()
	await reform_timer.timeout
	
	animator.play("reforming")
	await  animator.animation_finished
	
	animator.play("idle")
	await  animator.animation_finished
	
	
