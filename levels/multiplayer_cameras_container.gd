extends HBoxContainer
@onready var camera_1: Camera2D = $SubViewportContainer1/SubViewport1/Camera1
@onready var camera_2: Camera2D = $SubViewportContainer2/SubViewport2/Camera2

@onready var world = get_parent()
var player_1: CharacterBody2D
var player_2: CharacterBody2D

func _ready() -> void:
	player_1 = world.players[0]
	player_2 = world.players[1]
	rotation = 1
	
func _process(delta: float) -> void:
	var diff = player_1.position - player_2.position
	var angle = atan2(-diff.y, -diff.x)
	rotation = angle
	camera_1.global_rotation = angle
	camera_2.global_rotation = angle

	
	
