extends Node2D

	
func _ready():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		var sprite = N.get_node("Sprite")
		tween.tween_property(sprite, "scale", sprite.get_scale(), 0.2).from(Vector2.ZERO)

			
func reset_screen():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		tween.tween_property(N, "scale", Vector2.ZERO, 0.3)
		if N.is_in_group("enemy"):
			N.curr_state = N.states.dead
		#tween.tween_callback(N.queue_free)
