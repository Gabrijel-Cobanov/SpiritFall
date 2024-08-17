extends BossState
class_name BossFlameStart

var anim_length: float = 0.5
var anim_duration: float

func Enter(ctx: BossStateMachine):
	ctx.Reset_Velocity_X()
	ctx.num_of_attacks_done += 1
	anim_duration = anim_length
	ctx.animator.play("flame_start")
	
func Update(ctx: BossStateMachine):
	if anim_duration <= 0:
		ctx.Switch_State(ctx.flame_middle)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: BossStateMachine):
	pass
