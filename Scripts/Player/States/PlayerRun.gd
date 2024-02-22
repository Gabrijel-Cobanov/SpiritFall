extends PlayerBaseState
class_name PlayerRun

func Enter(ctx: PlayerStateMachine):
	print("enter run YYYYYY")
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	ctx.Move_Player_Horizontally()
	
func Exit(ctx: PlayerStateMachine):
	pass

func Check_Transitions(ctx: PlayerStateMachine):
	if ctx.movement_input.x == 0:
		ctx.Switch_State(ctx.idle)
	elif ctx.input_buffer.Get_Last_Input_Action() == "jump":
		ctx.Switch_State(ctx.jump_start)
	elif ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.current_dash_cooldown <= 0:
		ctx.Switch_State(ctx.dash)
	elif ctx.coyote.coyote_timer <= 0:
		ctx.Switch_State(ctx.jump_middle)
	#elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
		#ctx.Switch_State(ctx.swing1)
