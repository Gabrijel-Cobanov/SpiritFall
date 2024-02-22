extends Player_Base_State
class_name Player_Jump_Start

var jump_start_speed: float = 75

func Enter(ctx: Player_State_Machine):
	ctx.is_jumping = false;
	ctx.animation_player.play("Spirit/jump_start")
	
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if ctx.the_spirit.velocity.y > ctx.JUMP_VELOCITY/1.6 and !ctx.is_grounded:
		ctx.SwitchState(ctx.jump_middle)
	elif ctx.is_attacking:
		ctx.SwitchState(ctx.swing1)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	ctx.Move_Player(jump_start_speed)
