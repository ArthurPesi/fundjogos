extends Node2D

@onready var world = get_parent()

func _on_play_pressed() -> void:
	world.load_scene(constants.scene_types.MENU, constants.menus.CHAR_SELECTION)

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/config.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("quit_keyboard"):
		get_tree().quit()
