extends PlayerBaseState
class_name PlayerDash

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	print("enter dash")
	ctx.can_dash = false
	ctx.animator.play("dash")
	anim_duration = 0.38
	ctx.should_apply_gravity = false
	ctx.CB2D.velocity.y = 0
	ctx.dash_cooldown.start()
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	Dash(ctx)
	
func Exit(ctx: PlayerStateMachine):
	ctx.should_apply_gravity = true
	ctx.CB2D.velocity.x = 0
	
func Dash(ctx: PlayerStateMachine):
	var direction: int
	if ctx.is_facing_right:
		direction = 1
	else:
		direction = -1
	ctx.CB2D.velocity.x = direction * ctx.DASH_VELOCITY
	
func Check_Transitions(ctx: PlayerStateMachine):
	if anim_duration <= 0:
		if ctx.CB2D.is_on_floor() and ctx.movement_input.x != 0:
			ctx.Switch_State(ctx.run)
		elif ctx.input_buffer.Get_Last_Input_Action() == "attack":
			ctx.Switch_State(ctx.swing1)
		elif ctx.input_buffer.Get_Last_Input_Action() == "jump":
			ctx.Switch_State(ctx.jump_start)
		elif ctx.CB2D.is_on_floor():
			ctx.Switch_State(ctx.idle)
		else:
			ctx.Switch_State(ctx.jump_middle)
