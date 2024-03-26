extends EnemyBaseState
class_name EnemyIdleState

var idle_time: float
var min_idle_time: float = 2
var max_idle_time: float = 7

func Enter(ctx: EnemyStateMachine):
	ctx.Reset_Velocity_X()
	idle_time = randf() * max_idle_time
	if idle_time < min_idle_time:
		idle_time = min_idle_time
	ctx.animator.play(ctx.enemy_name + "/idle")
	
func Update(ctx: EnemyStateMachine, delta: float):
	# Add a condition here to transition to move state to pursue
	Check_Transitions(ctx)
	
func Physics_Update(ctx: EnemyStateMachine, delta: float):
	idle_time -= delta
	
func Exit(ctx: EnemyStateMachine):
	pass
	
func Check_Transitions(ctx: EnemyStateMachine):
	if ctx.should_pursue or idle_time <= 0:
		ctx.Switch_State(ctx.move)
	if ctx.should_attack and ctx.can_attack:
		ctx.Switch_State(ctx.attack)
