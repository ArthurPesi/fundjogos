extends Control

@onready var world: Node2D = $"../../../.."

func _on_resume_pressed() -> void:
	world.pause_game()


func _on_quit_pressed() -> void:
	world.pause_game()
	world.remove_all_players()
	world.load_scene(constants.scene_types.MENU, constants.menus.MAIN_MENU)
