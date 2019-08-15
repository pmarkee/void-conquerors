extends Area2D

signal die
signal shoot

export var speed = 300
export var max_lives = 3
var lives
var can_shoot
var screen_size

func _ready():
    screen_size = get_tree().get_root().get_node("Background").texture.size
    lives = max_lives
    can_shoot = true

func _process(delta):
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    elif Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    elif can_shoot and Input.is_action_just_pressed("ui_accept"):
        # Upon pressing spacebar, tell the Main scene that a shot has happened, then reset the shot timer.
        # TODO enable shooting while moving.
        emit_signal("shoot")
        can_shoot = false
        $ShotTimer.start(0.45)

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    
    position += velocity * delta
    position.x = clamp(position.x, GlobalSharedContent.PLAYER_SPRITE_SIZE.x / 2, screen_size.x - GlobalSharedContent.PLAYER_SPRITE_SIZE.x / 2)
    position.y = clamp(position.y, 0, screen_size.y)

func _on_ShotTimer_timeout():
    can_shoot = true

func _on_PlayerBody_area_entered(area):
    print("ouch")
    lives -= 1
    if !lives:
        emit_signal("die")
        queue_free()
