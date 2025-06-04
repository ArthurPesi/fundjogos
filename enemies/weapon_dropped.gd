extends Area2D

var ammo

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_collect(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_collect(null)
