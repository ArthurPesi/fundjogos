extends Node2D

var target: Vector2
var target_rotation
func _ready():
	$AnimatedSprite2D.play("default")
func _process(_delta: float) -> void:
	if get_parent().position.distance_squared_to(target) < 100000:
		global_position = target + Vector2.RIGHT.rotated(target_rotation) * -150
		global_rotation = target_rotation
	else:
		position = Vector2.ZERO
		look_at(target)
