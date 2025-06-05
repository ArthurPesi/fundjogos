extends Node2D

var player_amt: int = 0
var player_ready_amt: int = 0
const MAX_PLAYERS = 2

@onready var world = get_parent()

const CHARACTER_MENU = preload("res://menus/character_menu.tscn")
var character_menu_instances: Array[Node]
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	character_menu_instances.resize(MAX_PLAYERS)

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
		character_menu_instances[player_amt] = CHARACTER_MENU.instantiate()
		character_menu_instances[player_amt].player = player_amt
		h_box_container.add_child(character_menu_instances[player_amt])
		player_amt += 1

	if event.is_action("quit_gamepad") and event.is_pressed() and world.is_device_active(event.device):
		remove_all_players()
	if event.is_action("quit_keyboard") and event.is_pressed() and world.is_device_active(-1):
		remove_all_players()

func remove_all_players():
	world.remove_all_players()
	for i in character_menu_instances:
		if i:
			i.queue_free()
	player_amt = 0

func add_ready() -> void:
	player_ready_amt += 1
	if player_ready_amt == player_amt:
		world.load_scene(constants.scene_types.LEVEL, world.curr_level)
		
func remove_ready():
	player_ready_amt -= 1
