extends Node2D

var wall_color: Color
var curr_level = 0
	
func _ready():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		var sprite = N.get_node("Sprite")
		if N.is_in_group("obstacle"):
			tween.tween_property(sprite, "scale:y", sprite.get_scale().y, 0.2).from(0)
			sprite.modulate = wall_color
		else:
			tween.tween_property(sprite, "scale", sprite.get_scale(), 0.2).from(Vector2.ZERO)

func reset_screen():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		if N.is_in_group("enemy"):
			N.curr_state = N.states.dead
			tween.tween_property(N, "scale", Vector2.ZERO, 0.3)
		else:
			tween.tween_property(N, "scale:y", 0, 0.3)
		
		#tween.tween_callback(N.queue_free)
