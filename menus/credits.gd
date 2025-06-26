extends Node2D

@onready var world = get_parent()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("quit_keyboard") or Input.is_action_just_pressed("quit_gamepad")):
		world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
		world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)
