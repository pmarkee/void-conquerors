extends Area2D

export var velocity = Vector2(0, 450)

func _process(delta):
    position += velocity * delta
    if position.y >= GlobalSharedContent.BOTTOM_POS:
        queue_free()

# Whenever it exits the screen or hits something, just destruct.
func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_AlienProjectile_area_entered(area):
    queue_free()
