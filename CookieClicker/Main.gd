extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cookie_button_pressed():
	score = score  + 1
	$ScoreLabel.text = str(score)
