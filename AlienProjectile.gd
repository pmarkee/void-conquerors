extends AnimatedSprite

export var velocity = Vector2(0, 450)

func _process(delta):
    position += velocity * delta

# Whenever it exits the screen or hits something, just destruct.
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_AlienProjectileBody_area_entered(area):
    queue_free()
