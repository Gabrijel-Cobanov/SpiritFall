extends PlayerBaseState
class_name PlayerJumpEnd

func Enter(ctx: PlayerStateMachine):
	print("enter jump end")
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	pass

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	pass
	
func Exit(ctx: PlayerStateMachine):
	pass

func Check_Transitions(ctx: PlayerStateMachine):
	if ctx.movement_input.x != 0:
		ctx.Switch_State(ctx.run)
	elif ctx.input_buffer.Get_Last_Input_Action() == "jump":
		ctx.Switch_State(ctx.jump_start)
	elif ctx.input_buffer.Get_Last_Input_Action() == "dash":
		ctx.Switch_State(ctx.dash)
	#elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
		#ctx.Switch_State(ctx.swing1)
