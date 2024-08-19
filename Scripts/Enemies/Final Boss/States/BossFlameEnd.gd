extends BossState
class_name BossFlameEnd

var anim_length: float = 0.6
var anim_duration: float

func Enter(ctx: BossStateMachine):
	ctx.animator.play("flame_end")
	anim_duration = anim_length

func Update(ctx: BossStateMachine):
	if anim_duration <= 0:
		Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: BossStateMachine):
	ctx.can_attack_player = false
	ctx.attack_timer.start()
	
func Check_Transitions(ctx: BossStateMachine):
	if ctx.should_pursue_player:
		ctx.Switch_State(ctx.move)
	elif ctx.should_attack_player and ctx.can_spawn_walker_bot:
		ctx.Switch_State(ctx.spawn_walker)
	elif ctx.should_attack_player and ctx.can_attack_player:
		ctx.Switch_State(ctx.swing)
	else:
		ctx.Switch_State(ctx.idle)
