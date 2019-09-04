extends Area2D

signal die
signal shoot
signal reached_bottom

export var MIN_SHOOT_TIME = 5
export var MAX_SHOOT_TIME = 120

export var NUM_FRAMES = 2
var current_frame = 0

func _ready():
    add_to_group("enemies")
    add_to_group("aliens")
    $AlienShotTimer.start(rand_range(0, MAX_SHOOT_TIME + 1))

func move(vec):
    # Move by a given vector and update animation frame.
    self.position += vec
    if self.position.y >= GlobalSharedContent.BOTTOM_POS:
        emit_signal("reached_bottom")
    current_frame = (current_frame + 1) % NUM_FRAMES
    $AlienSprite.set_frame(current_frame)

func update_speed_scale(speed):
    self.speed_scale = speed

func _on_Alien_area_entered(area):
    emit_signal("die")
    queue_free()

func _on_AlienShotTimer_timeout():
    emit_signal("shoot", self)
    $AlienShotTimer.start(rand_range(MIN_SHOOT_TIME + 1, MAX_SHOOT_TIME + 1))

func set_animation(animation_type):
    $AlienSprite.set_animation(animation_type)
