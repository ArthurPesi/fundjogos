extends Node2D


@onready var world = get_parent()

func _on_main_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("quit_keyboard"):
		world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
		world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)
