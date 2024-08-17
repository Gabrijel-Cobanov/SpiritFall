extends BossState
class_name BossSwing

var lunge_speed: float = 40
var time_to_lunge:float = 0.5
var anim_length: float = 0.7
var anim_duration: float

func Enter(ctx: BossStateMachine):
	ctx.Reset_Velocity_X()
	ctx.num_of_attacks_done += 1
	anim_duration = anim_length
	ctx.animator.play("swing")
	

func Update(ctx: BossStateMachine):
	if anim_duration <= 0:
		Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	if anim_duration == time_to_lunge:
		Lunge(ctx)
	
	
func Exit(ctx: BossStateMachine):
	ctx.can_attack_player = false
	ctx.attack_timer.start()
	ctx.Reset_Velocity_X()
	
func Check_Transitions(ctx: BossStateMachine):
	if ctx.should_pursue_player:
		ctx.Switch_State(ctx.move)
	elif ctx.should_attack_player and ctx.can_spawn_walker_bot:
		ctx.Switch_State(ctx.spawn_walker)
	elif ctx.should_attack_player:
		ctx.Switch_State(ctx.flame_start)
	else:
		ctx.Switch_State(ctx.idle)
		
func Lunge(ctx: BossStateMachine):
	var x = ctx.CB2D.velocity.x
	if x > 0:
		ctx.CB2D.velocity.x = lunge_speed
	else:
		ctx.CB2D.velocity.x = -lunge_speed
