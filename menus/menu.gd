extends Node2D

@onready var world = get_parent()

func _on_play_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	world.load_scene(constants.scene_types.MENU, constants.menus.CHAR_SELECTION)

func _on_settings_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	world.load_scene(constants.scene_types.MENU, constants.menus.SETTINGS)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("quit_keyboard"):
		get_tree().quit()
