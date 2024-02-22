extends Player_Base_State
class_name Player_Death

var anim_duration: float

func Enter(ctx: Player_State_Machine):
	anim_duration = 0.5
	ctx.animation_player.play("Spirit/die")
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if anim_duration <= 0:
		print("Player has died")
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	anim_duration -= delta
	
