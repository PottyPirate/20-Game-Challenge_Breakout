class_name Paddle
extends CharacterBody2D

# These variables will show up in the editor
@export var speed = 400
@export var left_action = "key_a"
@export var right_action = "key_d"	

# This function runs every single physics frame. Perfect for movement!
func _physics_process(delta):
	var paddle_width = get_node("CollisionShape2D").shape.get_rect().size[1]
	var direction = 0
	if Input.is_action_pressed(left_action):
		direction = -1 # left
	elif Input.is_action_pressed(right_action):
		direction = 1 # right
	
	# Set our vertical velocity
	velocity.x = direction * speed
	
	# This is the Godot function that actually moves our character
	move_and_collide(Vector2(velocity.x * delta, 0))

	# Stop the paddle from going off-screen
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, paddle_width, screen_size.x - (paddle_width))
