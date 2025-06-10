extends VBoxContainer

var characters = ["fighter", "mage", "paladin", "rogue"]
var character_resources = []
var active: int = 1
var player
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
	if active > 0:
		active -= 1
	else:
		active = characters.size() - 1
	character.texture = character_resources[active]

func _on_next_button_down() -> void:
	if active < characters.size() - 1:
		active += 1
	else:
		active = 0
	character.texture = character_resources[active]

func _on_ready_button_down() -> void:
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
	ready_button.visible = true
	return_button.visible = false
	next_button.disabled = false
	prev_button.disabled = false
	char_selection.remove_ready()
