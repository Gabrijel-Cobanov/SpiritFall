extends Node2D

@onready var area_left_teleport_right = $AreaLeftTeleportRight
@onready var area_right_teleport_left = $AreaRightTeleportLeft

@onready var marker_right = $MarkerRight
@onready var marker_left = $MarkerLeft


# Called when the node enters the scene tree for the first time.
func _ready():
	area_left_teleport_right.body_entered.connect(Teleport_Player_Right)
	area_right_teleport_left.body_entered.connect(Teleport_Player_Left)

func Teleport_Player_Right(body: CharacterBody2D):
	body.position.x = marker_right.global_position.x
	
func Teleport_Player_Left(body: CharacterBody2D):
	body.position.x = marker_left.global_position.x
