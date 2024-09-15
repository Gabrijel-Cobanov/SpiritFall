extends BossMove
class_name BossDeath

var anim_duration: float

@onready var contact_damage_area = $"../../AttackComponent/ContactDamageArea"
@onready var fire_area = $"../../AttackComponent/FireArea"
@onready var swing_area = $"../../AttackComponent/SwingArea"
@onready var final_boss = $"../.."


func Enter(ctx: BossStateMachine):
	anim_duration = 5.7
	ctx.animator.play("death")
	contact_damage_area.monitoring = false
	fire_area.monitoring = false
	swing_area.monitoring = false
	final_boss.set_collision_layer_value(2, false)
	
func Update(ctx: BossStateMachine):
	if anim_duration <= 0:
		Exit(ctx)
	
func Pyhsics_Update(ctx: BossStateMachine, delta: float):
	anim_duration -= delta
	
func Exit(ctx: BossStateMachine):
	var boss = get_tree().get_first_node_in_group("boss")
	GlobalSignalBus.show_platforms.emit()
	boss.queue_free()
