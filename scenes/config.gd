extends Node2D


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2d.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
