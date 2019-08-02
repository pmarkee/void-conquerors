extends TextureRect

export (PackedScene) var Alien
export (PackedScene) var AlienProjectile
export (PackedScene) var Projectile

# TODO consider organizing some of these constant infos into an auto-load.

### VARIABLES FOR ALIEN SPACING AND MOVING LOGIC ###
# Spacing #
export var ALIEN_START_POS = Vector2(60, 60)
export var HORIZONTAL_ALIEN_SPACING = 50
export var VERTICAL_ALIEN_SPACING = 60
export var HORIZONTAL_ALIEN_COUNT = 11
export var VERTICAL_ALIEN_COUNT = 5

# Move speed #
# Initial time between moves (seconds).
export var INITIAL_MOVE_TIME = 1
# Reduce the time between moves after this many dead aliens.
export var REDUCE_FREQ = 5
# Reduce the time between moves by this much (seconds).
export var REDUCE_BY = 0.08
# The current time between moves.
var current_move_time = INITIAL_MOVE_TIME

# Move size and direction #
export var HORIZONTAL_MOVE_SIZE = 20
export var VERTICAL_MOVE_SIZE = 20
# After how many horizontal moves should we step down vertically?
export var STEP_DOWN_AFTER = 5
# How many horizontal steps have we made since last moving down vertically?
var horizontal_steps_done = 1
# Current direction of moving
# -1 = negative change to x coordinate = move left
# +1 = positive change to x coordinate = move right
var current_move_dir = 1

### GENERAL GAME INFO ###
var total_alien_count = HORIZONTAL_ALIEN_COUNT * VERTICAL_ALIEN_COUNT
var alien_count
var aliens_dead = 0

var score
var hi_score

func _ready():
    score = 0
    alien_count = HORIZONTAL_ALIEN_COUNT * VERTICAL_ALIEN_COUNT
    instantiate_aliens()
    $AlienMoveTimer.start(current_move_time)
    randomize()

func instantiate_aliens():
    var alien
    var counter = 0
    for i in range(VERTICAL_ALIEN_COUNT):
        for j in range(HORIZONTAL_ALIEN_COUNT):
            # Instantiate a new alien, place them in a grid
            alien = Alien.instance()
            add_child(alien)
            alien.position = Vector2(ALIEN_START_POS.x + j * VERTICAL_ALIEN_SPACING,
                                     ALIEN_START_POS.y + i * HORIZONTAL_ALIEN_SPACING)
            var animation_type
            if i == 0:
                animation_type = GlobalSharedContent.AlienType.RED
            elif i in [1, 2]:
                animation_type = GlobalSharedContent.AlienType.YELLOW
            elif i in [3, 4]:
                animation_type = GlobalSharedContent.AlienType.GREEN
            else:
                print("SHIT HIT THE FAN")

            alien.set_animation(animation_type)

    # Tell the game whenever an alien has died and stuff needs to be updated.
    get_tree().call_group("aliens", "connect", "die", self, "_on_Alien_die")
    # Tell the game whenever an alien has shot and a projectile needs to be placed.
    get_tree().call_group("aliens", "connect", "shoot", self, "_on_Alien_shoot")

func move_aliens():
    # SOME NOTES ON THIS FUNCTION
    # I don't like that the Alien move logic is implemented here, but:
    # 1. each Alien instance computing their moves would be stupid
    # because they all need to make the same moves anyway.
    # 2. Thread safety is also problematic if Alien instances have shared variables,
    # which they logically should have since they move by the same rules.
    #
    # A possible workaround is to handle all the shared data as local vars in Alien instances,
    # but that's way more stupid than just putting the move logic here. And there would still be
    # no guarantee that they don't get out of sync by some black magic.
    # Yet another idea is to create some AlienManager scene which manages this,
    # but that's barely different than this solution.
    # TODO consider creating an AlienManager scene for handling this and other Alien logic.

    var move_vector = Vector2()
    if horizontal_steps_done == 0:
        move_vector.y += VERTICAL_MOVE_SIZE
        current_move_dir *= -1
    else:
        move_vector.x += current_move_dir * HORIZONTAL_MOVE_SIZE

    get_tree().call_group("aliens", "move", move_vector)

    horizontal_steps_done += 1
    horizontal_steps_done %= STEP_DOWN_AFTER + 1

    $AlienMoveTimer.start(current_move_time)

func _on_Player_shoot():
    # Instantiate a projectile and place it above the player.
    var projectile = Projectile.instance()
    add_child(projectile)
    projectile.position = Vector2($Player.position.x, $Player.position.y - 50)

func _on_Alien_shoot(who):
    var alien_projectile = AlienProjectile.instance()
    add_child(alien_projectile)
    alien_projectile.position = Vector2(who.position.x, who.position.y + 50)

func _on_Alien_die():
    # Increment score and reduce remaining alien count
    print("that's it, I'm dead")
    score += 1
    alien_count -= 1
    if (alien_count == 0):
        game_won()

    # Check if a speed increase needs to be made.
    aliens_dead = (aliens_dead + 1) % REDUCE_FREQ
    if aliens_dead == 0:
        current_move_time -= REDUCE_BY

func game_won():
    # TODO
    print("you won")

func game_over():
    # TODO
    print("game over")
