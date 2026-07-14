# FILE: Level/Level.gd
extends Node2D

var score = 0
var lives = 0

# Get references to our other nodes so we can use them in code.
@onready var ball = $Ball
@onready var label = $UI/Control/Score
@onready var game_over_text = $UI/Control/GameOver

# This function runs when the level starts.
func _ready():
	# This is the magic! We tell the Level to listen for the ball's alarm.
	ball.out_of_bounds.connect(_on_ball_out_of_bounds)
	ball.hit_block.connect(_on_hit_block)
	
	# Start a fresh game
	new_game()

func new_game():
	score = 0
	lives = 3
	update_display()
	ball.start()

# A simple function to keep the text on screen updated.
func update_display():
	label.text = "Score: " + str(score) + "\nLives: " + str(lives)
	if lives == 0:
		game_over_text.text = "GAME OVER"
		get_tree().paused = true
	
# This function runs automatically whenever the ball emits its "out_of_bounds" signal.
func _on_ball_out_of_bounds():
	lives -= 1
	update_display()
	
func _on_hit_block():
	score += 1
	update_display()
