extends AudioStreamPlayer

func _ready() -> void:
	connect("finished", play)
