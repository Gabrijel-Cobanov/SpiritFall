extends Sprite2D
class_name HubTree

@onready var l1 = $Leaves1
@onready var l2 = $Leaves2
@onready var l3 = $Leaves3
@onready var l4 = $Leaves4
@onready var l5 = $Leaves5
@onready var l6 = $Leaves6
@onready var l7 = $Leaves7
@onready var l8 = $Leaves8
@onready var l9 = $Leaves9

# later we read this from disk, when I learn how to do that
var num_of_found_secrets: int
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var game_data = SaveSystem.get_var("save_file_1")
	num_of_found_secrets = game_data.total_found_totems
	
	var leaves_array = [l1, l2, l3, l4, l5, l6, l7, l8]
	if num_of_found_secrets == 0:
		pass
	elif num_of_found_secrets > 0 and num_of_found_secrets <= 8:
		for i in range(0, num_of_found_secrets):
			leaves_array[i].visible = true
	elif num_of_found_secrets == 9:
		for i in range(0, num_of_found_secrets-1):
			leaves_array[i].visible = false
		l9.visible = true
