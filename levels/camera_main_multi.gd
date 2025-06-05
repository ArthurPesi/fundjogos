extends Camera2D
@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"

func _process(delta):
	position = lerp(player_1.position, player_2.position, 0.5)
