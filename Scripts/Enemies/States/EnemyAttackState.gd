extends EnemyBaseState
class_name EnemyAttackState

var anim_duration: float

func Enter(ctx: EnemyStateMachine):
	anim_duration = 0.8
	ctx.can_attack = false
	ctx.animator.play(ctx.enemy_name + "/attack")
	ctx.Reset_Velocity_X()
	
func Update(ctx: EnemyStateMachine, delta: float):
	if anim_duration <= 0:
		Check_Transitions(ctx)
	
func Physics_Update(ctx: EnemyStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: EnemyStateMachine):
	ctx.attack_timer.start()
	
func Check_Transitions(ctx: EnemyStateMachine):
	if ctx.should_pursue:
		ctx.Switch_State(ctx.move)
	else:
		ctx.Switch_State(ctx.idle)
