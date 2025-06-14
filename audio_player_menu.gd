extends AudioStreamPlayer

func play_sound(sound_effect):
	set_stream(sound_effect)
	pitch_scale = randf_range(1,1.7)
	connect("finished", queue_free)
	play()
