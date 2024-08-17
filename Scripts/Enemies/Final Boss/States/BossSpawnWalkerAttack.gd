extends BossState
class_name BossSpawnWalker

var anim_length: float = 0.9
var anim_duration: float

func Enter(ctx: BossStateMachine):
	anim_duration = anim_length
	ctx.Reset_Velocity_X()
	ctx.animator.play("spawn_walker")
	ctx.num_of_attacks_done += 1

func Update(ctx: BossStateMachine):
	pass
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	if anim_duration <= 0:
		Check_Transitions(ctx)
	
func Exit(ctx: BossStateMachine):
	ctx.can_attack_player = false
	ctx.attack_timer.start()
	
func Check_Transitions(ctx: BossStateMachine):
	ctx.Switch_State(ctx.idle)
