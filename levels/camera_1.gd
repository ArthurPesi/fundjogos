extends Camera2D

@onready var world = $"../../../.."
var player_1

func _ready() -> void:
	player_1 = world.players[0]
	
func _process(delta: float) -> void:
	position = player_1.position
