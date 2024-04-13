extends Node2D
class_name ManaIndicator

@onready var mana_ui = $ManaUi
var num_of_frames: int = 6
var current_frame: int = 5

func Increase_Mana(ammount: int):
	if mana_ui.frame + ammount < num_of_frames:
		mana_ui.frame += ammount
	else:
		mana_ui.frame = num_of_frames-1
	
func Decrease_Mana(ammount: int):
	if mana_ui.frame - ammount > num_of_frames:
		mana_ui.frame -= ammount
	else:
		mana_ui.frame = 0
