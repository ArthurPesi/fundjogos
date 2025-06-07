extends Camera2D
@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"
@onready var world = $"../../.."
var delta_pos: Vector2
const MAX_DISTANCE := Vector2(576,324)

func _process(delta):
	position = lerp(player_1.position, player_2.position, 0.5)
	delta_pos = abs(player_1.position - player_2.position)
	if (delta_pos.x > MAX_DISTANCE.x or delta_pos.y > MAX_DISTANCE.y) and world.get_active_camera() == constants.cameras.MAIN:
		world.switch_to_split_multiplayer_cameras()
		print("out of reach")
	#elif delta_pos.x < MAX_DISTANCE.x and delta_pos.y < MAX_DISTANCE.y and world.get_active_camera() == constants.cameras.SPLIT:
		#world.switch_to_main_multiplayer_camera()
		#print("within bounds")
