extends Node

@onready var timer: Timer = $Timer
const BACKGROUND = preload("res://scenes/background.tscn")

var skin_textures= [
	preload("res://assets/characters/white_sheep.png"),
	preload("res://assets/characters/demon.png"),
	preload("res://assets/characters/enemy_bot.png"),
	preload("res://assets/characters/evil_demon.png"),
	preload("res://assets/characters/pigeon.png"),
	preload("res://assets/characters/parrot.png"),
	preload("res://assets/characters/bot.png")
]

var platform_theme=[]
var selected_skin = 0
var player_dead = false
var diffculty = 0

func get_selected_skin_texture():
	return skin_textures[selected_skin]
	
func set_selected_skin(num):
	selected_skin = num
	
func apply_skin_to_player(player_node):
	if player_node != null:
		player_node.get_node('Sprite2D').texture = skin_textures[selected_skin]

func get_player_dead():
	return player_dead

func player_died():
	player_dead=true
	


func reload_game() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	player_dead=false
	
func start_game():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func set_diffculty(diff:int) -> void:
	diffculty = diff

func _ready() -> void:
	return


	

	
