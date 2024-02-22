extends Player_Base_State
class_name Player_Run

func Enter(ctx: Player_State_Machine):
	ctx.animation_player.play("Spirit/turn_to_run")
	ctx.animation_player.play("Spirit/run")
	
func Exit(ctx: Player_State_Machine):
	ctx.animation_player.play("Spirit/stop")

func Update(ctx: Player_State_Machine, delta: float):
	if ctx.is_jumping and ctx.is_grounded:
		ctx.SwitchState(ctx.jump_start)
	elif ctx.is_dashing:
		ctx.SwitchState(ctx.dash)
	elif !ctx.is_grounded:
		ctx.SwitchState(ctx.jump_middle)
	elif ctx.is_attacking:
		ctx.SwitchState(ctx.swing1)
	elif !ctx.is_moving:
		ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	ctx.Move_Player(ctx.speed)
