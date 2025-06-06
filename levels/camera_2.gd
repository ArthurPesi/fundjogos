extends Camera2D

@onready var world = $"../../../.."
var player_2

func _ready() -> void:
	player_2 = world.players[1]
	
func _process(delta: float) -> void:
	position = player_2.position
