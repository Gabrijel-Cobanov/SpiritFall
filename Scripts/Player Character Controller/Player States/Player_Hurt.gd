extends Player_Base_State
class_name Player_Hurt

@onready var freeze_frame_component = $"../../Freeze_Frame_Component"

var freeze_time_scale: float = 0.01
var freeze_duration: float = 0.6


var anim_duration: float

func Enter(ctx: Player_State_Machine):
	anim_duration = 0.3
	freeze_frame_component.Apply_Freeze_Frame(freeze_time_scale, freeze_duration)
	ctx.animation_player.play("Spirit/hurt")
	
func Exit(ctx: Player_State_Machine):
	ctx.the_spirit.velocity = Vector2.ZERO 

func Update(ctx: Player_State_Machine, delta: float):
	if anim_duration <= 0:
		if ctx.has_died:
			ctx.SwitchState(ctx.death)
		elif ctx.is_moving:
			ctx.SwitchState(ctx.run)
		elif !ctx.is_grounded:
			ctx.SwitchState(ctx.jump_middle)
		elif ctx.is_attacking:
			ctx.SwitchState(ctx.swing1)
		elif ctx.is_jumping and ctx.is_grounded:
			ctx.SwitchState(ctx.jump_start)
		else:
			ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	anim_duration -= delta
	ctx.the_spirit.velocity.x = move_toward(ctx.the_spirit.velocity.x, 0, 1)
	ctx.the_spirit.move_and_slide()
