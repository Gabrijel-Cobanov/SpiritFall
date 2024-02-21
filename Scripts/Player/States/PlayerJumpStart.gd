extends PlayerBaseState
class_name PlayerJumpStart

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	print("enter jump start")
	anim_duration = ctx.MAX_HEIGHT_TIME
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	
func Exit(ctx: PlayerStateMachine):
	pass
	
func Check_Transitions(ctx: PlayerStateMachine):
	if ctx.input_buffer.Get_Last_Input_Action() == "dash":
		ctx.Switch_State(ctx.dash)
	elif ctx.CB2D.is_on_floor():
		ctx.Switch_State(ctx.jump_end)
	else:
		ctx.Switch_State(ctx.jump_middle)
	#elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
		#ctx.Switch_State(ctx.swing1)
