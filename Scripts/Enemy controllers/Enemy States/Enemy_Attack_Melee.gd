extends Enemy_Base_State

var anim_duration: float

func Enter(ctx: Enemy_State_Machine):
	anim_duration = 0.65
	ctx.can_attack = false
	ctx.attack_timer.start()
	ctx.animation_player.play(ctx.enemy_name+'/attack')
	
func Exit(ctx: Enemy_State_Machine):
	pass

func Update(ctx: Enemy_State_Machine, delta: float):
	if anim_duration <= 0:
		if ctx.Get_Distance_To_Player_X() > ctx.pursue_range:
			ctx.SwitchState(ctx.idle)
		elif ctx.Get_Distance_To_Player_X() <= ctx.pursue_range:
			ctx.SwitchState(ctx.pursue)
		elif ctx.Get_Distance_To_Player_X() <= ctx.attack_range and ctx.can_attack:
			ctx.SwitchState(ctx.attack)
	
func Pysics_Update(ctx: Enemy_State_Machine, delta: float):
	anim_duration -= delta
	ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 10)
	ctx.CB2D.move_and_slide()
	
