extends Node2D
@onready var HUD: Control = $RevolverHud
@onready var sprite: AnimatedSprite2D = $revolver

var ammo = 6
var SFX = constants.sound_effects.REVOLVER_SHOT
const PRECISION = 0.1
const BULLET_LIFE = 10
const COOLDOWN = 0.4
const SHAKE_STRENGTH = 40.0
const MIN_BULLETS = 1
const MAX_BULLETS = 1
const BULLET_DURATION = 4
const MIN_BULLET_SPEED = 600
const MAX_BULLET_SPEED = 650
const ANIMATION_INCREASE = 4
const ANIMATION_DURATION = 0.15
const ANIMATION_SQUASH = 0.3
const ANIMATION_FALLBACK = 1

		
