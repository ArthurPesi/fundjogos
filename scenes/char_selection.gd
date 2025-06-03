extends Node2D

@onready var world = get_parent()
func _input(event: InputEvent) -> void:
	if event.is_action("join_gamepad"):
		if Input.is_action_just_pressed("join_gamepad"):
			print(event.device)
			world.add_player(event.device, constants.device_types.GAMEPAD)
			world.load_scene(world.scene.LEVEL, world.curr_level)
	if event.is_action("join_keyboard"):
		if Input.is_action_just_pressed("join_keyboard"):
			print(event.device)
			world.add_player(event.device, constants.device_types.KEYBOARD)
			world.load_scene(world.scene.LEVEL, world.curr_level)
