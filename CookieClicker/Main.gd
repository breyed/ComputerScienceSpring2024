extends Node2D

var score = 0
var points_per_click = 1
var multi_click_price = 10

func _ready():
	add_to_score(0)

func _on_cookie_button_pressed():
	add_to_score(points_per_click)

func _on_multi_click_button_pressed():
	points_per_click = points_per_click + 3
	add_to_score(-multi_click_price)
	
func add_to_score(points):
	score = score + points
	$ScoreLabel.text = str(score)
	$MultiClickButton.disabled = score < multi_click_price
	$AudioStreamPlayer.play()
	$FlyingCookieSprite/AnimationPlayer.stop()
	$FlyingCookieSprite/AnimationPlayer.play("flying_cookie")
