extends Path2D

@export var speed: int = 100
@export var target_position: Vector2

@onready var animation_player = $PathFollow2D/Area2D/AnimationPlayer
@onready var path_follow_2d = $PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("falling")
	curve.set_point_out(0, Vector2(target_position.x/2, -abs(target_position.x)))
	curve.set_point_position(1, target_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target_position: return
		
	if path_follow_2d.progress_ratio >= 0.98: queue_free()
	
	path_follow_2d.progress += speed * delta
