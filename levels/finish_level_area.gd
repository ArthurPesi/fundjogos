extends Area2D
@onready var world = $"../../../.."

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		world.check_level_up()
