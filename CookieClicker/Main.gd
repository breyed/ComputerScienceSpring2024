extends Node2D

var score = 0
var points_per_click = 1
var multi_click_price = 10
var grannies = 0
var grandpas = 0
var grandkids = 0
var nannies = 0

var frames = 0

func _ready():
	add_to_score(0)

func _process(x):
	frames = frames + 1
	if frames >= 60 / (grandpas + 1):
		frames = 0
		add_to_score(grannies)

func _on_cookie_button_pressed():
	add_to_score(points_per_click)

func _on_multi_click_button_pressed():
	points_per_click = points_per_click + 3
	add_to_score(-multi_click_price)

func _on_granny_button_pressed():
	grannies = grannies + 1

func _on_grandpa_button_pressed():
	grandpas = grandpas + 2
	
func add_to_score(points):
	for grandkid in range(grandkids):
		if randf() < 0.1: return
	
	score = score + points
	$ScoreLabel.text = str(score)
	$Bonuses/Box/MultiClickButton.disabled = score < multi_click_price
	
	# Show a flying cookie animation.
	if points > 0:
		var flying_cookie = $FlyingCookieSprite.duplicate()
		add_child(flying_cookie)
		var player = flying_cookie.get_node("AnimationPlayer")
		player.play("flying_cookie_animation")

		var on_finished = func(animation): flying_cookie.queue_free()
		player.animation_finished.connect(on_finished)
