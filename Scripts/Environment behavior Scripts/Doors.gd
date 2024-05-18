extends Node2D

@onready var door_1_active = $Door1Active
@onready var door_2_active = $Door2Active
@onready var door_3_active = $Door3Active

func Open_First_Door():
	door_1_active.visible = true

func Open_Second_Door():
	door_2_active.visible = true
	
func Open_Third_Door():
	door_3_active.visible = true
	
func _ready():
	Open_First_Door()

