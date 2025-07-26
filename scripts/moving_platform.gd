extends StaticBody2D

var move_speed = 300
var direction = Vector2(1,0)

func _process(delta: float) -> void:
	position += direction * move_speed * delta
	if global_position.x < 100 or global_position.x > 980:
		direction *= -1
