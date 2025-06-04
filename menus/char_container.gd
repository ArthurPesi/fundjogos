extends VBoxContainer

var characters = ["fighter", "mage", "paladin", "rogue"]
var character_resources = []
var active: int = 1
var player
@onready var world = get_parent().get_parent().get_parent()
@onready var char_selection = get_parent().get_parent()

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
	char_selection.add_ready()
	
