extends Camera2D
@onready var player: CharacterBody2D = $"../Player1"

func _process(delta):
	position = player.position
