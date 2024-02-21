extends PlayerBaseState
class_name PlayerIdle

func Enter(ctx: PlayerStateMachine):
	print("enter idle")
	
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	if ctx.CB2D.velocity.x != 0:
		ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 25)
	
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
