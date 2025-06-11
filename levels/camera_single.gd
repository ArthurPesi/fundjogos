extends Camera2D
@onready var player: CharacterBody2D = $"../Player1"

func _process(_delta):
	position = player.position
