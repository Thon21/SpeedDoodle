extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -1300.0
const FLOAT_VELOCITY = -800
const SPRING_JUMP_VELOCITY = -5000.0

var player_position = 0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var s_jump: AudioStreamPlayer = $SJump

var floating = false

func _ready():
	# Set the sprite texture based on the selected skin
	sprite_2d.texture = GameManager.get_selected_skin_texture()

func _physics_process(delta: float) -> void:
	# Add gravity.
	var screen_size = get_viewport().size
	if floating:
		velocity.y = FLOAT_VELOCITY
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			velocity.y = JUMP_VELOCITY
			s_jump.play()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Screen wrapping logic.
	player_position = global_position
	if player_position.x < 0:
		player_position.x = screen_size.x
	elif player_position.x > screen_size.x:
		player_position.x = 0
	global_position = player_position

	# Move the player and check collisions.
	move_and_slide()

	# Check for collisions and handle interactions with trap platforms.
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("TrapPlatform"):  # Ensure it's a trap platform
			if collision.get_normal().y < 0:  # Check if the collision is from the top
				collision.get_collider().break_platform()  # Trigger the platform's breaking logic

func set_float() -> void:
	floating = true
	animation_player.play("Bubble")
	await get_tree().create_timer(3.0).timeout
	floating = false

func spring_jump() -> void:
	velocity.y = SPRING_JUMP_VELOCITY
