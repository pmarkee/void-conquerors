extends Area2D

# TODO this is only player projectile behavior yet
# implement enemy projectile

export var velocity = Vector2(0, -550)

func _process(delta):
    position += velocity * delta

# Just destruct whenever we exit the screen or hit something
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_Projectile_area_entered(area):
    queue_free()
