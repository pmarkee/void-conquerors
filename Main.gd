extends TextureRect

export (PackedScene) var Alien
export (PackedScene) var Projectile

export var ALIEN_START_POS = Vector2(100, 100)
export var HORIZONTAL_ALIEN_SPACING = 50
export var VERTICAL_ALIEN_SPACING = 60
export var HORIZONTAL_ALIEN_COUNT = 5
export var VERTICAL_ALIEN_COUNT = 11

var alien_count
var score
var hi_score

func _ready():
    score = 0
    alien_count = HORIZONTAL_ALIEN_COUNT * VERTICAL_ALIEN_COUNT
    instantiate_aliens()

func instantiate_aliens():
    var alien
    var counter = 0
    for i in range(HORIZONTAL_ALIEN_COUNT):
        for j in range(VERTICAL_ALIEN_COUNT):
            # Instantiate a new alien, place them in a grid
            alien = Alien.instance()
            add_child(alien)
            alien.position = Vector2(ALIEN_START_POS.x + j * VERTICAL_ALIEN_SPACING,
                                     ALIEN_START_POS.y + i * HORIZONTAL_ALIEN_SPACING)
            # Tell the game that an alien has died and stuff needs to be updated.
            alien.connect("die", self, "_on_Alien_die")

func _on_Player_shoot():
    # Instantiate a projectile and place it above the player.
    var projectile = Projectile.instance()
    add_child(projectile)
    projectile.position = Vector2($Player.position.x, $Player.position.y - 50)

func _on_Alien_die():
    # Increment score and reduce remaining alien count
    print("that's it, I'm dead")
    score += 1
    alien_count -= 1
    if (alien_count == 0):
        game_won()

func game_won():
    # TODO
    print("you won")
