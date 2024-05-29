extends PlayerBaseState
class_name PlayerDeath

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("death")
	anim_duration = 0.7
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	if anim_duration <= 0:
		Exit(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 10)
	
func Exit(ctx: PlayerStateMachine):
	GlobalSignalBus.player_died.emit()
