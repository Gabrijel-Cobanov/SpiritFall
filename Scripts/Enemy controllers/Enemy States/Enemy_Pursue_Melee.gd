extends Enemy_Base_State

func Enter(ctx: Enemy_State_Machine):
	ctx.animation_player.play(ctx.enemy_name+'/turn_to_walk')
	ctx.animation_player.play(ctx.enemy_name+'/walk')
	
func Exit(ctx: Enemy_State_Machine):
	pass

func Update(ctx: Enemy_State_Machine, delta: float):
	if ctx.Get_Distance_To_Player_X() <= ctx.attack_range and ctx.can_attack:
		ctx.SwitchState(ctx.attack)
	elif ctx.Get_Distance_To_Player_X() > ctx.pursue_range:
		ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Enemy_State_Machine, delta: float):
	ctx.Move_Enemy()
