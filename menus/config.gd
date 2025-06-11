extends Control

@onready var world = get_parent()
@onready var option_button: OptionButton = $CanvasLayer/VBoxContainer/HBoxContainer/OptionButton

func _ready() -> void:
	print(TranslationServer.get_locale())
	for i in option_button.item_count:
		if option_button.get_item_id(i) == constants.locales.get(TranslationServer.get_locale()):
			option_button.select(i)

func _on_play_pressed() -> void:
	world.load_scene(constants.scene_types.MENU, constants.menus.CHAR_SELECTION)

func _on_back_pressed() -> void:
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)

func _input(event):
	if event.is_action_pressed("quit_gamepad") or event.is_action_pressed("quit_keyboard"):
		_on_back_pressed()

func _on_option_button_item_selected(index: int) -> void:
	TranslationServer.set_locale(constants.locales.keys()[index])
