extends Node2D
@onready var HUD: Control = $ShotgunHud
@onready var sprite: AnimatedSprite2D = $shotgun

var ammo = 4
const SFX = constants.sound_effects.SHOTGUN_SHOT
const PRECISION = 0.27
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 0.8
const MIN_BULLET_SPEED = 600
const MAX_BULLET_SPEED = 869
const COOLDOWN = 0.7
const SHAKE_STRENGTH = 70.0
const ANIMATION_INCREASE = 3.5
const ANIMATION_DURATION = 0.2
const ANIMATION_SQUASH = 1
const ANIMATION_FALLBACK = 1
