extends Node2D

const colors = [
	[169, 34, 34, 255]
]
var curr_level = 0

func get_level_color():
	return Color.from_rgba8(colors[curr_level][0],colors[curr_level][1],colors[curr_level][2],colors[curr_level][3])

	
func _ready():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		var sprite = N.get_node("Sprite")
		tween.tween_property(sprite, "scale", sprite.get_scale(), 0.2).from(Vector2.ZERO)
		if N.is_in_group("obstacle"):
			sprite.modulate = get_level_color()

			
func reset_screen():
	var tween = get_tree().create_tween().set_parallel(true)
	for N in get_children():
		tween.tween_property(N, "scale", Vector2.ZERO, 0.3)
		if N.is_in_group("enemy"):
			N.curr_state = N.states.dead
		#tween.tween_callback(N.queue_free)
