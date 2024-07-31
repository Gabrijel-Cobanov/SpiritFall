extends PlayerBaseState
class_name PlayerHeal

var anim_duration: float

func Enter(ctx: PlayerStateMachine):
	anim_duration = 0.8
	ctx.can_heal = false
	ctx.animator.play("heal")
	ctx.heal_sound.play()
	
func Update(ctx: PlayerStateMachine, delta:float):
	Check_Transitions(ctx)

func Physics_Update(ctx: PlayerStateMachine, delta:float):
	anim_duration -= delta
	if ctx.CB2D.velocity.x != 0:
		ctx.CB2D.velocity.x = move_toward(ctx.CB2D.velocity.x, 0, 30)
	
func Exit(ctx: PlayerStateMachine):
	if anim_duration <= 0:
		ctx.heal_cooldown.start()
		ctx.health.Heal()
	else:
		ctx.can_heal = true

func Check_Transitions(ctx: PlayerStateMachine):
	if !ctx.heal_is_pressed:
		ctx.heal_sound.playing = false
	
	if anim_duration <=0 or !ctx.heal_is_pressed:
		if ctx.input_buffer.Get_Last_Input_Action() == "jump":
			ctx.Switch_State(ctx.jump_start)
		elif ctx.input_buffer.Get_Last_Input_Action() == "dash" and ctx.can_dash:
			ctx.Switch_State(ctx.dash)
		elif ctx.movement_input.x != 0:
			ctx.Switch_State(ctx.run)
		elif !ctx.CB2D.is_on_floor():
			ctx.Switch_State(ctx.jump_middle)
		elif ctx.input_buffer.Get_Last_Input_Action() == "attack"  and ctx.can_attack:
			ctx.Switch_State(ctx.swing1)
		else:
			ctx.Switch_State(ctx.idle)
