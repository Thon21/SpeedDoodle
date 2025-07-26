extends StaticBody2D

var falling = false
var fall_speed = 600

func _ready() -> void:
	set_process(false)


func check_collision(collision):
	if collision.normal.y > 0:
		await get_tree().create_timer(0.2).timeout
		break_platform()
		
func break_platform():
	falling = true
	set_process(true)

func _process(delta):
	if falling:
		position.y += fall_speed * delta  # Move the platform downward
		if position.y > get_viewport().size.y:  # Check if it has fallen off-screen
			queue_free()  # Remove the platform from the scene
