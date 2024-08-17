extends BossState
class_name BossFlameMiddle

var attack_duration: float = 1.6
var time_left: float
@onready var boss_flame = $"../../Visuals/BossFlame"

func Enter(ctx: BossStateMachine):
	time_left = attack_duration
	ctx.animator.play("flame_middle")
	boss_flame.visible = true

func Update(ctx: BossStateMachine):
	if time_left <= 0:
		ctx.Switch_State(ctx.flame_end)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	time_left -= delta
	
func Exit(ctx: BossStateMachine):
	boss_flame.visible = false
