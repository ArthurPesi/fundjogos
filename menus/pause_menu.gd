extends Control

@onready var world: Node2D = $"../../.."

func resume():
	hide()
	get_tree().paused = false

func pause():
	show()
	get_tree().paused = true

func _on_resume_pressed() -> void:
	resume()

func _input(event):
	if (event.is_action_pressed("quit_keyboard") or event.is_action_pressed("quit_gamepad")) and world.scene_type == constants.scene_types.LEVEL:
		if get_tree().paused:
			resume()
		else:
			pause()


func _on_quit_pressed() -> void:
	resume()
	world.remove_all_players()
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)
