extends PlayerBaseState
class_name PlayerHurt

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("hurt")
	ctx.i_frames_animator.play("i_frames")
	anim_duration = 0.3
	ctx.health.can_take_damage = false
	
func Update(ctx: PlayerStateMachine, delta:float):
	if anim_duration <= 0.15:
		ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 5)
	
	if anim_duration <= 0:
		ctx.Switch_State(ctx.idle)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	
func Exit(ctx: PlayerStateMachine):
	ctx.hurt_cooldown.start()
	pass
