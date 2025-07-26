extends Node

var platform_spacing = 180
var last_platform_y = 700  # Track the Y position of the last generated platform
var player_dead = false
var platform_chance
var platform_types = ["normal", "moving", "trap", "empty"]  # List of platform types
var last_platform_type = "normal"
const PLATFORM = preload("res://scenes/platform.tscn")
const MOVINGPLATFORM = preload("res://scenes/moving_platform.tscn")
const TRAPPLATFORM = preload("res://scenes/trap_platform.tscn")
const BUBBLE = preload("res://scenes/bubble.tscn")
const SPRING = preload("res://scenes/spring.tscn")

@onready var player: CharacterBody2D = $"../Player"
@onready var platforms: Node = $"../Platforms"
var thresholds = [-2000, -5000, -10000]
var difficulty_increment = 1
var platform_x = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for threshold in thresholds:
		if player.position.y < threshold:
			GameManager.set_diffculty(0 + (difficulty_increment * thresholds.find(threshold))) 
	
	if player.position.y < last_platform_y + 1500 : 
		spawn_platform(GameManager.diffculty)
		last_platform_y -= platform_spacing
		
	for child in platforms.get_children():
		if child.get_class() == "StaticBody2D":
			if child.position.y > player.position.y + 1500:  # Check if below screen
				child.queue_free()  # Remove platform
	pass


func spawn_platform(diffculty):
	var platform 
	if diffculty != null:
		match diffculty:
			0:platform_chance = [60, 30, 10, 0]
			1:platform_chance = [30, 40, 20, 10]
			2:platform_chance = [10, 40, 30, 20]
			3:platform_chance = [0, 20, 30, 50]
	
		var random_type = select_platform(platform_chance)
		if last_platform_type == "empty" and random_type == "empty":
			random_type = platform_types[randi() % (platform_types.size() - 1)]
			
		last_platform_type = random_type
		
		if random_type == "normal":
			platform = PLATFORM.instantiate()
		elif random_type == "moving":
			platform = MOVINGPLATFORM.instantiate()
		elif random_type == "trap":
			platform = TRAPPLATFORM.instantiate()
		elif random_type == "empty":
			return
		
		platform_x = randf()*880+100
		platform.position = Vector2(platform_x, last_platform_y-platform_spacing)
		var rand = randi() % 100
		if rand < 8:
			var item
			var rand1 = randi() % 100
			if rand1 < 50:
				item = BUBBLE.instantiate()
			else:
				item = SPRING.instantiate()
			platform.add_child(item)
			item.position.y -= 70
		add_child(platform)  


func select_platform(platform_chance):
	var rand = randi() % 100
	if rand < platform_chance[0]:
		return "normal"
	elif rand < platform_chance[0] + platform_chance[1]:
		return "moving"
	elif rand < platform_chance[0] + platform_chance[1] + platform_chance[2]:
		return "trap"
	else:
		return "empty"
