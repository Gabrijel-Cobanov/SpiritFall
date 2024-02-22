extends Player_Base_State
class_name Player_Jump_Middle

func Enter(ctx: Player_State_Machine):
	ctx.animation_player.play("Spirit/jump_middle")
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if ctx.is_grounded:
		ctx.SwitchState(ctx.jump_end)
	elif ctx.is_attacking:
		ctx.SwitchState(ctx.swing1)
	elif ctx.is_dashing:
		ctx.SwitchState(ctx.dash)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	ctx.the_spirit.velocity.y += ctx.gravity * delta * 0.5 #additional multiplier for falling
	ctx.Move_Player(ctx.speed)
