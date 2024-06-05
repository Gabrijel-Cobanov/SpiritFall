extends Sprite2D

@export var totem_id: int

@onready var area_2d = $Area2D
@onready var selected = $CollectibleStoneSelected

@onready var animation_player = $AnimationPlayer

var should_be_awake: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.body_entered.connect(func(body): selected.visible = true)
	area_2d.body_exited.connect(func(body): selected.visible = false)
	
	if !should_be_awake:
		animation_player.play("idle")
	else:
		animation_player.play("awake")
	
	# read from the savefile whether this stone should be active
	# find the id, if it's flipped, turn on the stone when the level is first loaded and
	# destroy that wall! Ah, gamedev never ceases to amaze! That'll be fun to implement
	# Actually, it's not necesarry for this game, but I'll keep that in mind for the 
	# next one


