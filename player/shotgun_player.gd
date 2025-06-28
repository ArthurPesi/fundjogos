extends Node2D
@onready var HUD: Control = $ShotgunHud
@onready var sprite: AnimatedSprite2D = $shotgun

var ammo = 2
const SFX = constants.sound_effects.SHOTGUN_SHOT
const PRECISION = 0.44
const MIN_BULLETS = 13
const MAX_BULLETS = 24
const BULLET_DURATION = 0.39
const MIN_BULLET_SPEED = 460
const MAX_BULLET_SPEED = 919
const COOLDOWN = 0.7
const SHAKE_STRENGTH = 70.0
const ANIMATION_INCREASE = 3.5
const ANIMATION_DURATION = 0.2
const ANIMATION_SQUASH = 1
const ANIMATION_FALLBACK = 1
var curr_frame = 0
