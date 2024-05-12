extends EnemyBaseState
class_name EnemyMoveState

var wander_time: float
var max_wander_time: float = 1.5
var min_wander_time: float = 0.5

var direction: int

func Enter(ctx: EnemyStateMachine):
	wander_time = randf() * max_wander_time
	if int(wander_time*10) % 2 == 0:
		direction = 1
	else:
		direction = -1
	if wander_time <= min_wander_time:
		wander_time = min_wander_time
	ctx.animator.play(ctx.enemy_name + "/move")
	
func Update(ctx: EnemyStateMachine, delta: float):
	Check_Transitions(ctx)
	
func Physics_Update(ctx: EnemyStateMachine, delta: float):
	wander_time -= delta
	if ctx.should_pursue:
		ctx.Pursue()
	else:
		ctx.Wander(direction)
	
func Exit(ctx: EnemyStateMachine):
	pass
	
func Check_Transitions(ctx: EnemyStateMachine):
	if wander_time <= 0 and !ctx.should_pursue:
		ctx.Switch_State(ctx.idle)
	if ctx.should_attack and ctx.can_attack:
		ctx.Switch_State(ctx.attack)
