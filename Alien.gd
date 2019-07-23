extends AnimatedSprite

signal die

func _on_AlienBody_area_entered(area):
    emit_signal("die")
    queue_free()
