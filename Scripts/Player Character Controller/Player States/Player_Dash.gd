extends Player_Base_State
class_name Player_Dash

var anim_duration: float

func Enter(ctx: Player_State_Machine):
	ctx.is_dashing = false
	anim_duration = 0.4
	ctx.animation_player.play("Spirit/dash")
	ctx.should_apply_gravity = false
	
	
func Exit(ctx: Player_State_Machine):
	ctx.should_apply_gravity = true

func Update(ctx: Player_State_Machine, delta: float):
	if anim_duration <= 0:
		if ctx.is_attacking:
			ctx.SwitchState(ctx.swing1)
		elif ctx.is_dashing:
			ctx.SwitchState(ctx.dash)
		elif ctx.is_moving and ctx.is_grounded:
			ctx.SwitchState(ctx.run)
		elif !ctx.is_grounded:
			ctx.SwitchState(ctx.jump_middle)
		elif ctx.is_jumping and ctx.is_grounded:
			ctx.SwitchState(ctx.jump_start)
		elif !ctx.is_moving and ctx.is_grounded:
			ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	anim_duration -= delta
	ctx.Dash()
