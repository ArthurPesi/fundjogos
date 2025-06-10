extends Control

@onready var option_button: OptionButton = $CanvasLayer/VBoxContainer/HBoxContainer/OptionButton
@onready var pause_menu = $"../pause_menu"

func _ready() -> void:
	for i in option_button.item_count:
		if option_button.get_item_id(i) == constants.locales.get(TranslationServer.get_locale()):
			option_button.select(i)

func _on_play_pressed() -> void:
	pass

func _on_back_pressed() -> void:
	pause_menu.show()
	queue_free()

func _input(event):
	if event.is_action_pressed("quit_gamepad") or event.is_action_pressed("quit_keyboard"):
		_on_back_pressed()

func _on_option_button_item_selected(index: int) -> void:
	TranslationServer.set_locale(constants.locales.keys()[index])
