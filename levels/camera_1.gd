extends Camera2D

@onready var world = $"../../../.."
var player_1
var player_2

func _ready() -> void:
	player_1 = world.players[0]
	player_2 = world.players[1]
	
func _process(delta: float) -> void:
	position = player_1.position
