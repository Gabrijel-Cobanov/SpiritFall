extends BossState
class_name BossIdle

func Enter(ctx: BossStateMachine):
	ctx.animator.play("idle")
	ctx.Reset_Velocity_X()

func Update(ctx: BossStateMachine):
	Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	pass
	
func Exit(ctx: BossStateMachine):
	pass
	
func Check_Transitions(ctx: BossStateMachine):
	if ctx.should_pursue_player:
		ctx.Switch_State(ctx.move)
