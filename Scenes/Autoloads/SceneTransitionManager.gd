extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func Transition_To_Scene(scene_path: String):
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	get_tree().paused = true
	animation_player.play_backwards("fade_to_black")
	await animation_player.animation_finished
	get_tree().paused = false
