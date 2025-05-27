extends Area2D

var speed
var life = 1
var direction = Vector2()

func start(pos, dir, spd, lf):
	position = pos
	direction = dir
	speed = spd
	life = lf
	
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:v", 1, 0.12).from(10)

func _physics_process(delta: float) -> void:
	var next_pos: Vector2 = position + (direction * speed * delta)
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, next_pos)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider.is_in_group("player"):
			result.collider.die_player()
		elif result.collider.is_in_group("obstacle"):
			queue_free()

	position = next_pos
	life -= delta
	if life <= 0:
		queue_free()
