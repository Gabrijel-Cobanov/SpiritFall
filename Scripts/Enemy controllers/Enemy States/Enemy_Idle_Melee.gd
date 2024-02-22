extends Enemy_Base_State

func Enter(ctx: Enemy_State_Machine):
	ctx.animation_player.play(ctx.enemy_name+'/idle')
	
func Exit(ctx: Enemy_State_Machine):
	pass

func Update(ctx: Enemy_State_Machine, delta: float):
	if !ctx.is_on_ledge and ctx.is_inline_with_player:
		if ctx.Get_Distance_To_Player_X() <= ctx.attack_range and ctx.can_attack:
			ctx.SwitchState(ctx.attack)
		elif ctx.Get_Distance_To_Player_X() > ctx.attack_range and ctx.Get_Distance_To_Player_X() <= ctx.pursue_range:
			ctx.SwitchState(ctx.pursue)
	
func Pysics_Update(ctx: Enemy_State_Machine, delta: float):
	ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 20)
	ctx.CB2D.move_and_slide()
	
	
