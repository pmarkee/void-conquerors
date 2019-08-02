extends AnimatedSprite

signal die

export var NUM_FRAMES = 2
var current_frame = 0

func _ready():
    add_to_group("aliens")

func _on_AlienBody_area_entered(area):
    emit_signal("die")
    queue_free()

func move(vec):
    # Move by a given vector and update animation frame.
    self.position += vec
    current_frame = (current_frame + 1) % NUM_FRAMES
    set_frame(current_frame)

func update_speed_scale(speed):
    self.speed_scale = speed
