extends PlayerBaseState
class_name PlayerJumpEnd

var anim_duration: float
var early_transition_time: float

func Enter(ctx: PlayerStateMachine):
	print("enter jump end")
	ctx.animator.play("jump_end")
	anim_duration = 0.25
	early_transition_time = anim_duration/1.5
	ctx.CB2D.velocity.x /= 2
	pass
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	ctx.Move_Player_Horizontally()
	
	
func Exit(ctx: PlayerStateMachine):
	pass

func Check_Transitions(ctx: PlayerStateMachine):
	if anim_duration <= early_transition_time and ctx.input_buffer.Get_Last_Input_Action() == "jump":
		ctx.Switch_State(ctx.jump_start)
	elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
		ctx.Switch_State(ctx.swing1)
	
	if anim_duration <= 0:
		if ctx.movement_input.x != 0:
			ctx.Switch_State(ctx.run)
		elif ctx.input_buffer.Get_Last_Input_Action() == "jump":
			ctx.Switch_State(ctx.jump_start)
		elif ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.current_dash_cooldown <= 0:
			ctx.Switch_State(ctx.dash)
		elif ctx.movement_input.x == 0:
			ctx.Switch_State(ctx.idle)
		elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
			ctx.Switch_State(ctx.swing1)
