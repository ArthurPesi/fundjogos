extends Node2D

@onready var world = get_parent()

func _on_play_pressed() -> void:
	world.load_scene(constants.scene_types.MENU, constants.menus.CHAR_SELECTION)

func _on_back_pressed() -> void:
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)

func _input(event):
	if event.is_action_pressed("quit_gamepad") or event.is_action_pressed("quit_keyboard"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
