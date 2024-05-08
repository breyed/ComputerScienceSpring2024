extends Node2D

var score = 0
var points_per_click = 1
var multi_click_price = 10
var granny_price = 30
var grandpa_price = 50
var grannies = 0
var grandpas = 0
var grandkids = 0
var nannies = 0

var frames = 0

var clicksByScale = { 4: 0, 3: 0, 2: 0 }

func _ready():
	add_to_score(0)
	
	get_window().size = Vector2(2000, 1000)
	
	for _r in range(100):
		var random_cookie = $CookieButton.duplicate()
		var scale = randi_range(2, 4)
		random_cookie.scale = Vector2(1.0 / scale, 1.0 / scale)
		random_cookie.position = Vector2(randi_range(0, 2000), randi_range(0, 1000))
		
		var clicked = func():
			random_cookie.queue_free()
			clicksByScale[scale] = clicksByScale[scale] + 1
		random_cookie.connect('pressed', clicked)
		
		add_child(random_cookie)

func _process(_x):
	frames = frames + 1
	if frames >= 60.0 / (grandpas + 1):
		frames = 0
		add_to_score(grannies)

func _on_cookie_button_pressed():
	add_to_score(points_per_click)

func _on_multi_click_button_pressed():
	points_per_click = points_per_click + 3
	add_to_score(-multi_click_price)

func _on_granny_button_pressed():
	grannies = grannies + 1
	add_to_score(-granny_price)

func _on_grandpa_button_pressed():
	grandpas = grandpas + 2
	add_to_score(-grandpa_price)
	
func add_to_score(points):
	for grandkid in range(grandkids):
		if randf() < 0.1: return
	
	score = score + points
	$ScoreLabel.text = str(score)
	$ScoreDetailLabel.text = "Small: %d\nMedium: %d\nLarge: %d" % [clicksByScale[4], clicksByScale[3], clicksByScale[2]]
	$Bonuses/Box/MultiClickButton.disabled = score < multi_click_price
	$Bonuses/Box/GrannyButton.disabled = score < granny_price
	$Bonuses/Box/GrandpaButton.disabled = score < grandpa_price
	
	# Show a flying cookie animation.
	if points > 0:
		$AudioStreamPlayer.play()
		var flying_cookie = $FlyingCookieSprite.duplicate()
		add_child(flying_cookie)
		var player = flying_cookie.get_node("AnimationPlayer")
		player.play("flying_cookie_animation")

		var on_finished = func(_animation): flying_cookie.queue_free()
		player.animation_finished.connect(on_finished)
