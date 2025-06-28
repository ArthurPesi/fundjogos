extends Camera2D
@onready var player: CharacterBody2D = $"../Player1"

func _process(_delta):
	var extra = player.look_dir
	if extra.length_squared() < 50000:

		print(extra.length_squared())
		extra = Vector2.ZERO
		
	else:
		extra = extra.limit_length(400)
	position = lerp(player.position, player.position + extra, 0.4)
