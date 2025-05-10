extends Node2D

func _on_player_player_dead() -> void:
	get_tree().reload_current_scene.call_deferred()
