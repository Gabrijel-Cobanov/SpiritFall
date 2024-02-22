extends Player_Base_State
class_name Player_Jump_End

var anim_duration: float

func Enter(ctx: Player_State_Machine):
	ctx.animation_player.play("Spirit/jump_end")
	anim_duration = 0.15
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if anim_duration <= 0.08:
		if ctx.is_jumping:
			ctx.SwitchState(ctx.jump_start)
	
	if anim_duration <= 0:
		if ctx.is_moving:
			ctx.SwitchState(ctx.run)
		elif ctx.is_attacking:
			ctx.SwitchState(ctx.swing1)
		else:
			ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	anim_duration -= delta
	ctx.Move_Player(ctx.speed)
