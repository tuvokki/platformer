extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_score_label(Game.score)
	if !Game.won:
		lost()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _on_again_button_pressed():
	Game.restart()

func set_score_label(score: int):
	$ScoreLabel.text = "You scored " + str(score) + " points!"

func lost():
	$OutcomeLabel.text = "Oh no! You lost! :("
