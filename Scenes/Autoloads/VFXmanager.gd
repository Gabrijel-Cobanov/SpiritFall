extends Node2D


@onready var animator = $AnimationPlayer
@onready var hit_vfx = $VFXsprites/HitVfx

func Play_Hit_Anim(vfx_position: Vector2):
	hit_vfx.position = vfx_position
	var index = randi()%2 + 1
	hit_vfx.visible = true
	animator.play("hit_" + str(index))
	await animator.animation_finished
	hit_vfx.visible = false
	
func _ready():
	GlobalSignalBus.something_got_hit_at_pos.connect(Play_Hit_Anim)
