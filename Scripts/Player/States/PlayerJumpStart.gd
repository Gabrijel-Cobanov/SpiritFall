extends PlayerBaseState
class_name PlayerJumpStart

var anim_duration: float
const ADDITIONAL_GRAVITY: float = 50

func Enter(ctx: PlayerStateMachine):
	ctx.animator.play("jump_start")
	anim_duration = ctx.MAX_HEIGHT_TIME
	ctx.CB2D.velocity.y = ctx.JUMP_VELOCITY
	ctx.jump_sound.pitch_scale = randf_range(0.9, 1.1)
	ctx.jump_sound.play()
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	if !Input.is_action_pressed("jump"):
		ctx.CB2D.velocity.y += ADDITIONAL_GRAVITY
		ctx.Switch_State(ctx.jump_middle)
	ctx.Move_Player_Horizontally()

func Exit(ctx: PlayerStateMachine):
	pass
	
func Check_Transitions(ctx: PlayerStateMachine):
	if ctx.CB2D.velocity.y >= 0 or anim_duration <= 0:
		if ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.can_dash:
			ctx.Switch_State(ctx.dash)
		elif ctx.input_buffer.Get_Last_Input_Action() == "attack" and ctx.can_attack:
			ctx.Switch_State(ctx.swing1)
		elif ctx.CB2D.is_on_floor():
			ctx.Switch_State(ctx.jump_end)
		else:
			ctx.Switch_State(ctx.jump_middle)
