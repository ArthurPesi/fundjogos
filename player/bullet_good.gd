extends Area2D

var speed
var life = 1
var direction = Vector2()
var bullet_owner: CharacterBody2D
func start(pos, dir, spd, lf, parent):
	position = pos
	direction = dir
	speed = spd
	life = lf
	bullet_owner = parent
@onready var tween = get_tree().create_tween()

func _ready() -> void:
	tween.tween_property(self, "modulate:v", 1, 0.15).from(15)

func _physics_process(delta: float) -> void:
	var next_pos: Vector2 = position + ((direction) * speed * delta)
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, next_pos)
	var result = space_state.intersect_ray(query)
	if result:
		var object_hit = result.collider
		#if object_hit.is_in_group("enemy"):
			#object_hit.die()
		if object_hit.is_in_group("obstacle"):
			queue_free()

	position = next_pos
	life -= delta
	if life <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().die()
