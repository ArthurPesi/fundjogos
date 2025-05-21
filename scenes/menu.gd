extends Node2D


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2d.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/config.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
