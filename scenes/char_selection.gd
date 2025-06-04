extends Node2D

var player_amt: int = 0
var player_ready_amt: int = 0
const MAX_PLAYERS = 2

@onready var world = get_parent()

const CHARACTER_MENU = preload("res://character_menu.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _input(event: InputEvent) -> void:
	var device_type = null
	if event.is_action("join_gamepad"):
		if Input.is_action_just_pressed("join_gamepad") and !world.is_device_active(event.device) and player_amt < MAX_PLAYERS:
			device_type = constants.device_types.GAMEPAD
			
	if event.is_action("join_keyboard"):
		if Input.is_action_just_pressed("join_keyboard") and !world.is_device_active(-1) and player_amt < MAX_PLAYERS:
			device_type = constants.device_types.KEYBOARD
		
	if device_type != null:
		world.add_player(player_amt, event.device, device_type)
		var character_menu_instance = CHARACTER_MENU.instantiate()
		character_menu_instance.player = player_amt
		h_box_container.add_child(character_menu_instance)
		player_amt += 1

func add_ready() -> void:
	player_ready_amt += 1
	if player_ready_amt == player_amt:
		world.load_scene(constants.scene_types.LEVEL, world.curr_level)
