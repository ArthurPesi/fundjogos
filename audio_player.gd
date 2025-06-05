extends AudioStreamPlayer2D


func play_sound(sound_effect):
	set_stream(sound_effect)
	pitch_scale = randf_range(0.8,1.7)
	connect("finished", queue_free)
	play()
