extends Node2D
class_name ManaIndicator

@onready var mana_ui = $ManaUi
var num_of_frames: int = 6

func Increase_Mana():
	if mana_ui.frame + 1 < num_of_frames:
		mana_ui.frame += 1
	else:
		mana_ui.frame = num_of_frames-1
	
func Decrease_Mana():
	if mana_ui.frame - 1 > 0:
		mana_ui.frame = mana_ui.frame - 1
	else:
		mana_ui.frame = 0
