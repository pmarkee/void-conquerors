extends Area2D

signal die

var MOVE_SIZE = 35
var direction

func _ready():
    add_to_group("bosses")

func move():
    var vec = Vector2(-MOVE_SIZE if self.direction else MOVE_SIZE, 0)
    self.position += vec

func die(area):
    emit_signal("die")
    queue_free()
