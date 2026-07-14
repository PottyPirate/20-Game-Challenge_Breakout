# FILE: Ball/Ball.gd
extends CharacterBody2D

# This is like an alarm the ball can send out.
signal out_of_bounds
signal hit_block

# The speed of the ball.
@export var speed = 200
@export var paddle: Paddle

# This function will reset the ball's position and velocity.
func start():
	# Put the ball in the middle of the screen
	position = paddle.position + Vector2(0, -50)
	
	# Give it a random starting direction
	var direction_x = randf_range(-0.5, 0.5) # Go slightly left or right
	var direction_y = 1
	
	# Apply the direction and speed. .normalized() keeps the speed consistent.
	velocity = Vector2(direction_x, direction_y).normalized() * speed

# This function is called automatically when the game starts.
func _ready():
	start()

func _physics_process(delta):
	# Check if the ball went off the bottom
	if position.y > get_viewport_rect().size.y:
		out_of_bounds.emit() # Sound the alarm!
		start() # Reset the ball


	# Move the ball and check if we hit anything
	var collision = move_and_collide(velocity * delta)
	
	# If we hit something...
	if collision:
		# "bounce" is a handy function that reflects the velocity perfectly
		velocity = velocity.bounce(collision.get_normal())
		
		var thing_we_hit = collision.get_collider()
		if thing_we_hit.is_in_group("Blocks"):
			thing_we_hit.queue_free()
			hit_block.emit()
