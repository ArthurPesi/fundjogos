class_name constants

enum device_types {KEYBOARD, GAMEPAD}
enum game_modes {SINGLE, MULTI}
enum player_states {WALKING, ATTACKING, DEAD}
enum weapons {REVOLVER, UZI, SHOTGUN}
enum enemy_states {REGULAR, AGGRO, DEAD}
enum menus {MAIN_MENU, SETTINGS, CHAR_SELECTION, CREDITS, THANKS}
enum scene_types {MENU, LEVEL}
enum sound_modes {SOLO, SPLIT}
enum locales {en, pt}
enum sound_effects {
	SHOTGUN_SHOT, SHOTGUN_COCK, REVOLVER_SHOT, UZI_SHOT, NO_AMMO, PICK_UP,
	ENEMY_AGGRO, ENEMY_DEATH, 
	PLAYER_DEATH_MALE, PLAYER_DEATH_FEMALE, FIGHTER_ATTACK, PALADIN_ATTACK,
	BUTTON_CLICK
}
const PIOVERTWO: float = PI / 2
const PIOVERFOUR: float = PI / 4
const THREEPIOVERTWO: float = 3 * PI / 2
const DEBUG_LEVEL = 0
const sound_paths = [
	"guns/shotgun", "guns/cock_shotgun", "guns/revolver", "guns/uzi", "guns/no_ammo", "guns/pick_up",
	"enemies/aggro", "enemies/death",
	"players/death/male", "players/death/female", "players/attack/fighter", "players/attack/paladin",
	"UI/button_click"
]
