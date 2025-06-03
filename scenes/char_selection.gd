extends Node2D

var player_amt: int = 0
var player_ready_amt: int = 0
const MAX_PLAYERS = 1

@onready var world = get_parent()

const CHARACTER_MENU = preload("res://character_menu.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _input(event: InputEvent) -> void:
	if event.is_action("join_gamepad"):
		if Input.is_action_just_pressed("join_gamepad") and !world.is_device_active(event.device) and player_amt < MAX_PLAYERS:
			player_amt += 1
			world.add_player(event.device, constants.device_types.GAMEPAD)
			h_box_container.add_child(CHARACTER_MENU.instantiate())
			#adicionar ui com referencia para o jogador que criou
	if event.is_action("join_keyboard"):
		if Input.is_action_just_pressed("join_keyboard") and !world.is_device_active(-1) and player_amt < MAX_PLAYERS:
			player_amt += 1
			world.add_player(event.device, constants.device_types.KEYBOARD)
			h_box_container.add_child(CHARACTER_MENU.instantiate())

func add_ready() -> void:
	player_ready_amt += 1
	if player_ready_amt == player_amt:
		world.load_scene(world.scene.LEVEL, world.curr_level)
