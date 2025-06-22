extends Area2D

var ammo
var curr_frame = 0

func _ready():
	if curr_frame != 0:
		$revolver.frame = curr_frame
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_collect(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_collect(null)
