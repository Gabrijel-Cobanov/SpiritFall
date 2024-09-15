extends BossState
class_name BossMove

@onready var footstep = $"../../Audio/Footstep"

func Enter(ctx: BossStateMachine):
	ctx.animator.play("move")

func Update(ctx: BossStateMachine):
	Check_Transitions(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	ctx.Move(delta)
	
func Exit(ctx: BossStateMachine):
	pass
	
func Check_Transitions(ctx: BossStateMachine):
	if not ctx.should_pursue_player:
		ctx.Switch_State(ctx.idle)
	elif ctx.should_attack_player and ctx.can_spawn_walker_bot:
		ctx.Switch_State(ctx.spawn_walker)
	elif ctx.should_attack_player and ctx.can_attack_player:
		var x = randi_range(0, 1)
		if x == 1:
			ctx.Switch_State(ctx.swing)
		else:
			ctx.Switch_State(ctx.flame_start)

func Play_Footstep_Sound():
	footstep.pitch_scale = randf_range(0.9, 1.1)
	footstep.play()
