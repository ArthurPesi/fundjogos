extends AudioStreamPlayer2D

const MAX_DISTANCE_SOLO = 2000
const MAX_DISTANCE_SPLIT = 1000
@onready var world = get_parent().world

func play_sound(sound_effect):
	if world.sound_mode == constants.sound_modes.SOLO:
		print("perto")
		max_distance = MAX_DISTANCE_SOLO
	elif world.sound_mode == constants.sound_modes.SPLIT:
		print("longe")
		max_distance = MAX_DISTANCE_SPLIT
		
	set_stream(sound_effect)
	pitch_scale = randf_range(0.8,1.7)
	connect("finished", queue_free)
	play()
