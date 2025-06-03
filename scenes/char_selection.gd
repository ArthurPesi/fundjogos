extends Node2D

var player_amt: int = 1
var player_ready_amt: int = 0

@onready var world = get_parent()



func _input(event: InputEvent) -> void:
	if event.is_action("join_gamepad"):
		if Input.is_action_just_pressed("join_gamepad"):
			player_amt += 1
			world.add_player(event.device, constants.device_types.GAMEPAD)
			#adicionar ui com referencia para o jogador que criou
	if event.is_action("join_keyboard"):
		if Input.is_action_just_pressed("join_keyboard"):
			player_amt += 1
			world.add_player(event.device, constants.device_types.KEYBOARD)

func _on_ready_button_down() -> void:
	player_ready_amt += 1
	if player_ready_amt == player_amt:
		world.load_scene(world.scene.LEVEL, world.curr_level)
