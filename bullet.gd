extends Area2D

var speed
var life = 1
var direction = Vector2()

func start(pos, dir, spd, lf):
	position = pos
	direction = dir
	speed = spd
	life = lf
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("player_dead")


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	life -= delta
	if life <= 0:
		queue_free()
