extends Node2D

var target: Vector2

func _ready():
	print(target)
	$AnimatedSprite2D.play("default")
func _process(_delta: float) -> void:
	look_at(target)
	if Input.is_action_just_pressed("join_keyboard"):
		print(get_parent().position)
