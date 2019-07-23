extends TextureRect

export (PackedScene) var Projectile

var score
var hi_score

func _on_Player_shoot():
    # Instantiate a projectile and place it above the player.
    var projectile = Projectile.instance()
    add_child(projectile)
    projectile.position = Vector2($Player.position.x, $Player.position.y - 50)
