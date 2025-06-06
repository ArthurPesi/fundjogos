extends Camera2D
@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"
var delta_pos: Vector2
const MAX_DISTANCE := Vector2(250,100)

func _process(delta):
	position = lerp(player_1.position, player_2.position, 0.5)
	delta_pos = abs(player_1.position - player_2.position)
	if (delta_pos.x > MAX_DISTANCE.x or delta_pos.y > MAX_DISTANCE.y) and enabled == true:
		enabled = false
		print("out of reach")
	elif delta_pos.x < MAX_DISTANCE.x and delta_pos.y < MAX_DISTANCE.y and enabled == false:
		enabled = true
		print("within bounds")
