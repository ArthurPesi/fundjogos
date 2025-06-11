extends VBoxContainer

var characters = ["fighter", "mage", "paladin", "rogue"]
var character_resources = []
var active: int = 1
var player
var player_device_id
var player_device_type

@onready var world = get_parent().get_parent().get_parent()
@onready var char_selection = get_parent().get_parent()
@onready var ready_button: Button = $HBoxContainer2/ready
@onready var return_button: Button = $HBoxContainer2/Return
@onready var next_button: TextureButton = $HBoxContainer/next
@onready var prev_button: TextureButton = $HBoxContainer/prev

@onready var character: TextureRect = $HBoxContainer/char

func _ready() -> void:
	for i in characters:
		character_resources.append(load("res://sprites/" + i + "_ui.png"))
	character.texture = character_resources[active]

func _on_prev_button_down() -> void:
	if player_device_type == constants.device_types.KEYBOARD:
		prev_button_press()

func prev_button_press():
	if active > 0:
		active -= 1
	else:
		active = characters.size() - 1
	character.texture = character_resources[active]
	
func _on_next_button_down() -> void:
	if player_device_type == constants.device_types.KEYBOARD:
		next_button_press()

func next_button_press():
	if active < characters.size() - 1:
		active += 1
	else:
		active = 0
	character.texture = character_resources[active]

func _on_ready_button_down() -> void:
	if player_device_type == constants.device_types.KEYBOARD:
		ready_button_press()

func ready_button_press():
	world.players_settings[player].character_sprite = load("res://sprites/" + characters[active]+ "_sprite.tscn")
	world.players_settings[player].character = characters[active]
	if characters[active] == "fighter" or characters[active] == "paladin":
		world.players_settings[player].attack_sfx =  constants.sound_effects.get(characters[active].to_upper() + "_ATTACK")
	ready_button.visible = false
	return_button.visible = true
	next_button.disabled = true
	prev_button.disabled = true
	char_selection.add_ready()

func _on_return_button_down() -> void:
	if player_device_type == constants.device_types.KEYBOARD:
		return_button_press()
	
func return_button_press():
	ready_button.visible = true
	return_button.visible = false
	next_button.disabled = false
	prev_button.disabled = false
	char_selection.remove_ready()

func _input(event: InputEvent) -> void:
	if event.device == player_device_id and player_device_type == constants.device_types.GAMEPAD:
		if event.is_action("left_gamepad") and Input.is_action_just_pressed("left_gamepad"):
			prev_button_press()
		if event.is_action("right_gamepad") and Input.is_action_just_pressed("right_gamepad"):
			next_button_press()
		if event.is_action("join_gamepad") and Input.is_action_just_pressed("join_gamepad") and ready_button.visible:
			ready_button_press()
		elif event.is_action("join_gamepad") and Input.is_action_just_pressed("join_gamepad") and !ready_button.visible:
			return_button_press()
	if player_device_type == constants.device_types.KEYBOARD:
		if event.is_action("left_keyboard") and Input.is_action_just_pressed("left_keyboard"):
			prev_button_press()
		if event.is_action("right_keyboard") and Input.is_action_just_pressed("right_keyboard"):
			next_button_press()
		if event.is_action("join_keyboard") and Input.is_action_just_pressed("join_keyboard") and ready_button.visible:
			ready_button_press()
		elif event.is_action("join_keyboard") and Input.is_action_just_pressed("join_keyboard") and !ready_button.visible:
			return_button_press()
