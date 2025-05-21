extends Node2D

var paused = false
var pause_menu

func freeze(time):
	Engine.time_scale = 0.05
	await get_tree().create_timer(time * 0.05).timeout
	Engine.time_scale = 1

func _ready() -> void:
	Engine.time_scale = 1
	if get_tree().current_scene.name == "scene_2d":
		pause_menu = get_node("player/Camera2D/pause_menu")

func _on_player_player_dead() -> void:
	if get_tree():
		get_tree().reload_current_scene()
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2d.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/config.tscn")

func _input(event):
	if event.is_action_pressed("quit"):
		match get_tree().current_scene.name:
			"scene_2d":
				print("hi")
				if !paused:
					Engine.time_scale = 0
					pause_menu.show()
				if paused:
					Engine.time_scale = 1
					pause_menu.hide()
				paused = !paused
			"main_menu":
				get_tree().quit()
			"config":
				get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
				
func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed_config() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_2d.tscn")


func _on_resume_pressed() -> void:
	pass # Replace with function body.
