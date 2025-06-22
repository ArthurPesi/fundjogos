extends Node2D

@onready var HUD: Control = $UziHud
@onready var sprite: AnimatedSprite2D = $uzi

var ammo = 50
const SFX = constants.sound_effects.UZI_SHOT
const PRECISION = 0.32
const BULLET_DURATION = 0.5
const MIN_BULLET_SPEED = 700
const MAX_BULLET_SPEED = 800
const COOLDOWN = 0.05
const SHAKE_STRENGTH = 8.0
const MIN_BULLETS = 1
const MAX_BULLETS = 1
const ANIMATION_INCREASE = 2
const ANIMATION_DURATION = 0.08
const ANIMATION_SQUASH = 0.02
const ANIMATION_FALLBACK = 0
var curr_frame = 0
