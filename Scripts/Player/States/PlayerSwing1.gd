extends PlayerBaseState
class_name PlayerSwing1

var anim_duration: float
var early_transition_time: float

func Enter(ctx: PlayerStateMachine):
	ctx.is_attacking = false
	anim_duration = 0.3
	early_transition_time = 0.05
	Pick_Attack_Anim(ctx)
	ctx.attack_sound.pitch_scale = randf_range(0.9, 1.1)
	ctx.attack_sound.play()
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	if !ctx.CB2D.is_on_floor():
		ctx.Move_Player_Horizontally()
	else:
		ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 15)
	
func Exit(ctx: PlayerStateMachine):
	pass
	
func Check_Transitions(ctx: PlayerStateMachine):
	if anim_duration <= early_transition_time and ctx.input_buffer.Get_Last_Input_Action() == "jump":
		ctx.Switch_State(ctx.jump_start)
	
	if anim_duration <= 0:
		if ctx.is_attacking and ctx.can_attack:
			ctx.combo_counter += 1
			ctx.Switch_State(ctx.swing2)
		elif ctx.CB2D.is_on_floor():
			ctx.combo_counter = 1
			if ctx.movement_input.x != 0:
				ctx.Switch_State(ctx.run)
			elif ctx.input_buffer.Get_Last_Input_Action() == "jump":
				ctx.Switch_State(ctx.jump_start)
			elif ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.can_dash:
				ctx.Switch_State(ctx.dash)
			elif ctx.movement_input.x == 0:
				ctx.Switch_State(ctx.idle)
		else:
			ctx.combo_counter = 1
			ctx.Switch_State(ctx.jump_middle)
			
func Pick_Attack_Anim(ctx: PlayerStateMachine):
	if ctx.CB2D.is_on_floor():
		if ctx.movement_input.y < 0:
			ctx.animator.play("swing1_up")
		else:
			ctx.animator.play("swing1_side")
	else:
		if ctx.movement_input.y < 0:
			ctx.animator.play("swing1_up_air")
		elif ctx.movement_input.y > 0:
			ctx.animator.play("swing1_down_air")
		else:
			ctx.animator.play("swing1_side_air")
