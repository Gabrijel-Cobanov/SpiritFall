extends Node2D

@onready var walker_bot_spawnpoint = $"../WalkerBot_Spawnpoint"
@onready var final_boss = $"../.."

const WALKER_BOT = preload("res://Scenes/Enemies/WalkerBot.tscn")

func Spawn_Walker_Bot():
	var bot = WALKER_BOT.instantiate()
	var parent = get_tree().get_first_node_in_group("EnemySpawnNode")
	parent.add_child(bot)
	bot.global_position = walker_bot_spawnpoint.global_position
	GlobalSignalBus.player_spawned.emit()
	
