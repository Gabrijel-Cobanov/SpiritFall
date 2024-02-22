extends Player_Base_State
class_name Player_Swing_2

var anim_duration: float
var lunge_speed: float = 80

func Enter(ctx: Player_State_Machine):
	anim_duration = 0.3
	ctx.is_attacking = false
	if ctx.is_moving:
		if ctx.is_facing_right:
			ctx.the_spirit.velocity.x = lunge_speed
		else:
			ctx.the_spirit.velocity.x = -lunge_speed
	if ctx.is_grounded and ctx.direction_v == 0:
		ctx.animation_player.play("Spirit/attack_ground_swing_side_2")
	elif ctx.is_grounded and ctx.direction_v > 0:
		ctx.animation_player.play("Spirit/attack_ground_swing_up_2")
	elif !ctx.is_grounded and ctx.direction_v == 0:
		ctx.animation_player.play("Spirit/attack_air_swing_side_2")
	elif !ctx.is_grounded and ctx.direction_v > 0:
		ctx.animation_player.play("Spirit/attack_air_swing_up_2")
	elif !ctx.is_grounded and ctx.direction_v < 0:
		ctx.animation_player.play("Spirit/attack_air_swing_down_2")
	
func Exit(ctx: Player_State_Machine):
	pass

func Update(ctx: Player_State_Machine, delta: float):
	if anim_duration <= 0:
		if ctx.is_attacking:
			ctx.SwitchState(ctx.swing1)
		elif ctx.is_dashing:
			ctx.SwitchState(ctx.dash)
		elif !ctx.is_grounded:
			ctx.SwitchState(ctx.jump_middle)
		elif ctx.is_moving and ctx.is_grounded:
			ctx.SwitchState(ctx.run)
		elif ctx.is_jumping:
			ctx.SwitchState(ctx.jump_start)
		else:
			ctx.SwitchState(ctx.idle)
	
func Pysics_Update(ctx: Player_State_Machine, delta: float):
	anim_duration -= delta
	ctx.Lunge_Player()
