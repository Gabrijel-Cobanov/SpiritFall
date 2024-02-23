extends PlayerBaseState
class_name PlayerHurt

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("hurt")
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	pass

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	pass
	
func Exit(ctx: PlayerStateMachine):
	pass
