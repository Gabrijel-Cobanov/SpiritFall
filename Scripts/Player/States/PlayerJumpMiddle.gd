extends PlayerBaseState
class_name PlayerJumpMiddle

const ADDITIONAL_GRAVITY: float = 20

func Enter(ctx: PlayerStateMachine):
	print("enter jump middle")
	ctx.animator.play("jump_middle")
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	if ctx.CB2D.velocity.y <= ctx.MAX_FALL_VELOCITY:
		ctx.CB2D.velocity.y += ADDITIONAL_GRAVITY
	ctx.Move_Player_Horizontally()

func Exit(ctx: PlayerStateMachine):
	pass

func Check_Transitions(ctx: PlayerStateMachine):
	if ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.current_dash_cooldown <= 0:
		ctx.Switch_State(ctx.dash)
	elif ctx.CB2D.is_on_floor():
		ctx.Switch_State(ctx.jump_end)
