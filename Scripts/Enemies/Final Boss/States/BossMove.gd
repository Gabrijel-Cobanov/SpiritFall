extends BossState
class_name BossMove

func Enter(ctx: BossStateMachine):
	ctx.animator.play("move")

func Update(ctx: BossStateMachine):
	Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	ctx.Move(delta)
	
func Exit(ctx: BossStateMachine):
	pass
	
func Check_Transitions(ctx: BossStateMachine):
	if not ctx.should_pursue_player:
		ctx.Switch_State(ctx.idle)

