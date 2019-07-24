extends AnimatedSprite

signal die

func _ready():
    add_to_group("aliens")

func _on_AlienBody_area_entered(area):
    emit_signal("die")
    queue_free()
