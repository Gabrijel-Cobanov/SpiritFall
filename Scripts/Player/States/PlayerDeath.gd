extends PlayerBaseState
class_name PlayerDeath

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("death")
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	pass

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	pass
	
func Exit(ctx: PlayerStateMachine):
	pass
