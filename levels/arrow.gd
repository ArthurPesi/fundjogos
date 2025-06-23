extends Node2D

var target: Vector2

func _ready():
	$AnimatedSprite2D.play("default")
func _process(_delta: float) -> void:
	if get_parent().position.distance_squared_to(target) < 120000:
		global_position = target + Vector2(0, -150)
		global_rotation = constants.PIOVERTWO
	else:
		position = Vector2.ZERO
		look_at(target)
		
