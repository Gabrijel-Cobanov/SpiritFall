extends PlayerBaseState
class_name PlayerHurt

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("hurt")
	anim_duration = 0.3
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	if anim_duration <= 0.15:
		ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 5)
	
	if anim_duration <= 0:
		ctx.Switch_State(ctx.idle)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	
func Exit(ctx: PlayerStateMachine):
	pass
