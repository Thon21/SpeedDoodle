extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var right_boundary: CollisionShape2D = $"../Area2D/RightBoundary"
@onready var left_boundary: CollisionShape2D = $"../Area2D/LeftBoundary"
@onready var timer: Timer = $Timer
@onready var s_die: AudioStreamPlayer = $SDie
@onready var die_message: Control = $Camera2D/DieMessage

func _ready() -> void:
	GameManager.apply_skin_to_player(player)
	pass 
	
func _process(delta: float) -> void:
	if not GameManager.get_player_dead() and player.position.y > camera_2d.position.y + 1500:
		GameManager.player_died()
		die_message.visible = true
		s_die.play()
		await get_tree().create_timer(5.0).timeout
		GameManager.reload_game()
