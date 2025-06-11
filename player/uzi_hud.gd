extends Control
@onready var color_rect: ColorRect = $ColorRect
@onready var margin_container: MarginContainer = $MarginContainer
@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var load_rect: ColorRect = $MarginContainer2/HBoxContainer/LoadRect
@onready var loaded_rect: ColorRect = $MarginContainer2/HBoxContainer/LoadedRect



var rects: Array[ColorRect]
var ammo
func _ready() -> void:
	ammo = get_parent().ammo
	margin_container.reset_size()
	color_rect.size = margin_container.size
	for i in h_box_container.get_children():
		rects.append(i)
		
func on_shoot(_tween_time):
	if ammo < 1:
		return
	if ammo > 1:
		margin_container.reset_size()
		color_rect.size = margin_container.size
		ammo -= 1
		rects[0].custom_minimum_size.x = ammo
	else:
		queue_free()
