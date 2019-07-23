extends Sprite

signal shoot

export var speed = 200
export var max_lives = 3
var lives

var screen_size

func _ready():
    screen_size = get_viewport_rect().size
    lives = max_lives

func _process(delta):
    var velocity = Vector2()
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    elif Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    elif Input.is_action_just_pressed("ui_accept"):
        emit_signal("shoot")

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
