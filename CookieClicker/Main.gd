extends Node2D

var score = 0
var points_per_click = 1

func _on_cookie_button_pressed():
	if score == 10:
		points_per_click = 3
	score = score  + points_per_click
	$ScoreLabel.text = str(score)

	$AudioStreamPlayer.play()
