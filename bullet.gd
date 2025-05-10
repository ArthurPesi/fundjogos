extends Area2D

const SPEED = 800
var life = 100
var direction = Vector2()

func start(pos, dir):
	position = pos
	direction = dir
	
func _on_body_entered(body):
	print(body)
	if body.is_in_group("player"):
		get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	life -= 1
	if life <= 0:
		queue_free()
