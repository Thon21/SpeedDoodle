extends Label

@onready var player: CharacterBody2D = $"../../Player"

var score = 0
var highest_y = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_y = player.position.y
	if highest_y < -player_y:
		highest_y = -player_y
		score = int(highest_y*0.01)
		text = "Score: " + str(score)	
	
