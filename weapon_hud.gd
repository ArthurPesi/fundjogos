extends Control
@onready var color_rect: ColorRect = $ColorRect
@onready var margin_container: MarginContainer = $MarginContainer
@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var load_rect: ColorRect = $MarginContainer2/HBoxContainer/LoadRect
@onready var loaded_rect: ColorRect = $MarginContainer2/HBoxContainer/LoadedRect



var rects: Array[ColorRect]
var ammo = 6
func _ready() -> void:
	color_rect.size = margin_container.size
	for i in h_box_container.get_children():
		rects.append(i)
		
func on_shoot(tween_time):
	if ammo < 1:
		return
	rects[ammo - 1].hide()
	loaded_rect.hide()
	load_rect.show()
	var tween = get_tree().create_tween()
	tween.tween_property(load_rect, "custom_minimum_size:x", 6, tween_time).from(0)
	if ammo > 1:
		margin_container.reset_size()
		color_rect.size = margin_container.size
		
		tween.tween_callback(end_animation)
		ammo -= 1
	else:
		queue_free()
	
func end_animation():
	loaded_rect.show()
	load_rect.hide()
