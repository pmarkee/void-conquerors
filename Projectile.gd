extends AnimatedSprite

# TODO this is only player projectile behavior yet
# implement enemy projectile

export var velocity = Vector2(0, -650)
var screen_size

func _ready():
    screen_size = get_viewport_rect().size

func _process(delta):
    position += velocity * delta

# Just destruct whenever we exit the screen or hit something
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_ProjectileBody_area_entered(area):
    queue_free()
