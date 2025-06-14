extends Control

@onready var world: Node2D = $"../../.."
@onready var resume_button: Button = $VBoxContainer/resume
@onready var color_rect: ColorRect = $"../ColorRect"

const SETTINGS = preload("res://menus/settings_level.tscn")
var settings_instance

func _ready() -> void:
	color_rect.modulate = world.get_level_bg_color()
	color_rect.modulate.a = 0.7

func resume():
	hide()
	color_rect.hide()
	get_tree().paused = false

func pause():
	show()
	color_rect.show()
	resume_button.grab_focus()
	get_tree().paused = true

func _on_resume_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	resume()

func _input(event):
	if (event.is_action_pressed("quit_keyboard") or event.is_action_pressed("quit_gamepad")) and world.scene_type == constants.scene_types.LEVEL:
		if get_tree().paused:
			resume()
		else:
			pause()


func _on_quit_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	resume()
	world.remove_all_players()
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)


func _on_settings_pressed() -> void:
	world.play_sound_effect(constants.sound_effects.BUTTON_CLICK)
	settings_instance = SETTINGS.instantiate()
	hide()
	add_sibling(settings_instance)
