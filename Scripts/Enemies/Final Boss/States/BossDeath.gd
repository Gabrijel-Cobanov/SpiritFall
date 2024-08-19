extends BossMove
class_name BossDeath

var anim_duration: float

func Enter(ctx: BossStateMachine):
	anim_duration = 1.7
	ctx.animator.play("death")
	
	
func Update(ctx: BossStateMachine):
	if anim_duration <= 0:
		Exit(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: BossStateMachine):
	var boss = get_tree().get_first_node_in_group("boss")
	GlobalSignalBus.show_platforms.emit()
	boss.queue_free()
