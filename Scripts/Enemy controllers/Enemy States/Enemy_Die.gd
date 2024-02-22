extends Enemy_Base_State

var anim_duration: float

func Enter(ctx: Enemy_State_Machine):
	anim_duration = 1
	
	ctx.animation_player.play(ctx.enemy_name+'/die')
	
func Exit(ctx: Enemy_State_Machine):
	pass

func Update(ctx: Enemy_State_Machine, delta: float):
	if anim_duration <= 0:
		get_owner().queue_free()
	
func Pysics_Update(ctx: Enemy_State_Machine, delta: float):
	anim_duration -= delta
	ctx.CB2D.velocity = Vector2.ZERO
