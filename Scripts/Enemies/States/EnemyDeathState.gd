extends EnemyBaseState
class_name EnemyDeathState

var anim_duration: float

func Enter(ctx: EnemyStateMachine):
	ctx.animator.play(ctx.enemy_name + "/death")
	ctx.CB2D.set_collision_layer_value(2, false)
	anim_duration = ctx.death_anim_duration
	
func Update(ctx: EnemyStateMachine, delta: float):
	if anim_duration <= 0:
		ctx.CB2D.queue_free()
	
func Physics_Update(ctx: EnemyStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: EnemyStateMachine):
	pass
	
func Check_Transitions(ctx: EnemyStateMachine):
	pass
