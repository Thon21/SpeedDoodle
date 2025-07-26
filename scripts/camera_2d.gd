extends Camera2D

var fixed_x = 0

func _process(delta):
	# Set the camera's position
	  # Replace with the desired fixed X-coordinate
	var player_position = get_node("../Player").position.y
	if position.y > player_position:
		position = Vector2(fixed_x, player_position)

func get_camera_bottom():
	var screen_height = get_viewport_rect().size.y  # Get the height of the screen
	return position.y + screen_height / 2  # Camera's bottom boundary
