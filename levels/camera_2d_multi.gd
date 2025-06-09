extends Camera2D
var cameras

func _process(delta: float) -> void:
	if cameras:
		position = cameras.position
