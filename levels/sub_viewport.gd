extends SubViewport

@onready var world = $"../../.."

func _ready():
	world_2d = world.get_world_to_render()
