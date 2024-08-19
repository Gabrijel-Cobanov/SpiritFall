extends BossState
class_name BossIdle

var idle_length: float = 1.2
var idle_duration: float

func Enter(ctx: BossStateMachine):
	ctx.animator.play("idle")
	idle_duration = idle_length
	ctx.Reset_Velocity_X()

func Update(ctx: BossStateMachine):
	if idle_duration <= 0:
		Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	idle_duration -= delta
	
func Exit(ctx: BossStateMachine):
	ctx.num_of_attacks_done = 0
	
func Check_Transitions(ctx: BossStateMachine):
	if ctx.should_pursue_player:
		ctx.Switch_State(ctx.move)
	elif ctx.should_attack_player and ctx.can_spawn_walker_bot:
		ctx.Switch_State(ctx.spawn_walker)
	elif ctx.should_attack_player and ctx.can_attack_player:
		var x = randi_range(0, 1)
		if x == 1:
			ctx.Switch_State(ctx.swing)
		else:
			ctx.Switch_State(ctx.flame_start)
