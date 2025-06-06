extends Camera2D

@onready var world = $"../../../.."
var player_2
var player_1

func _ready() -> void:
	player_1 = world.players[0]
	player_2 = world.players[1]
	
func _process(delta: float) -> void:
	position = lerp(player_2.position, player_1.position, -0.3)
