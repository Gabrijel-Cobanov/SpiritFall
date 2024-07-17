extends Area2D

@onready var p0 = $p0.position
@onready var p1 = $p1.position
@onready var p2 = $p2.position

@export var source: CharacterBody2D

var time: float = 0

@onready var animation_player = $AnimationPlayer
var player_CB2D

func _ready():
	animation_player.play("falling")
	player_CB2D = get_tree().get_first_node_in_group("Player")
	p0 = source.global_position
	p2 = player_CB2D.global_position
	p1.x = (p0.x + p2.x)/2
	p1.y = -abs(p0.x - p2.x)
	
	body_entered.connect(func(body): queue_free())

	
func Bezier(t):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
	
func _physics_process(delta):
	position = Bezier(time)
	time += (delta*2)
	
	if time > 5:
		queue_free()
		

	
	
	


