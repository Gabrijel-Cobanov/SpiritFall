extends EnemyBaseState
class_name EnemyIdleState

var idle_time: float
var max_idle_time: float = 7

func Enter(ctx: EnemyStateMachine):
	ctx.Reset_Velocity_X()
	idle_time = randf() * max_idle_time
	ctx.animator.play(ctx.enemy_name + "/idle")
	
func Update(ctx: EnemyStateMachine, delta: float):
	# Add a condition here to transition to move state to pursue
	if idle_time <= 0:
		Check_Transitions(ctx)
	
func Physics_Update(ctx: EnemyStateMachine, delta: float):
	idle_time -= delta
	
func Exit(ctx: EnemyStateMachine):
	pass
	
func Check_Transitions(ctx: EnemyStateMachine):
	ctx.Switch_State(ctx.move)
