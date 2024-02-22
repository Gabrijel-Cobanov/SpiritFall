extends Player_Base_State
class_name Player_Idle

func Enter(ctx: Player_State_Machine):
	ctx.animation_player.play("Spirit/idle")
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if ctx.is_moving:
		ctx.SwitchState(ctx.run)
	elif ctx.is_dashing:
		ctx.SwitchState(ctx.dash)
	elif !ctx.is_grounded:
		ctx.SwitchState(ctx.jump_middle)
	elif ctx.is_attacking:
		ctx.SwitchState(ctx.swing1)
	elif ctx.is_jumping:
		ctx.SwitchState(ctx.jump_start)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	pass
