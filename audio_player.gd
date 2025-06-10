extends AudioStreamPlayer2D

const MAX_DISTANCE_SOLO = 2000
const MAX_DISTANCE_SPLIT = 1000
@onready var world: Node2D =  $"../../.."

func play_sound(sound_effect):
	if world.sound_mode == constants.sound_modes.SOLO:
		max_distance = MAX_DISTANCE_SOLO
	elif world.sound_mode == constants.sound_modes.SPLIT:
		max_distance = MAX_DISTANCE_SPLIT
		
	set_stream(sound_effect)
	pitch_scale = randf_range(0.9,1.7)
	connect("finished", queue_free)
	play()
