extends Sprite2D

@export var totem_id: int

@onready var area_2d = $Area2D
@onready var stone_selected = $CollectibleStoneSelected


@onready var animation_player = $AnimationPlayer

var is_awake: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	stone_selected.visible = false
	
	area_2d.body_entered.connect(func(body): if !is_awake: stone_selected.visible = true)
	area_2d.body_exited.connect(func(body): stone_selected.visible = false)
	
	var game_data = SaveSystem.get_var("save_file_1")
	var totem_found = game_data.found_totem_ids[totem_id]
	
	if totem_found == 1:
		is_awake = true
	
	if !is_awake:
		animation_player.play("idle")
	else:
		animation_player.play("awake")
		
func _process(delta):
	if !is_awake and stone_selected.visible and Input.is_action_just_pressed("interact"):
		stone_selected.visible = false
		is_awake = true
		animation_player.play("waking")
		await animation_player.animation_finished
		animation_player.play("launching")
		await animation_player.animation_finished
		animation_player.play("awake")
		Save_Progress()
		
func Save_Progress():
	var game_data = SaveSystem.get_var("save_file_1")
	game_data.total_found_totems += 1
	game_data.found_totem_ids[totem_id] = 1
	SaveSystem.set_var("save_file_1", game_data)
	SaveSystem.save()
		
