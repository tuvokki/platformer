extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_quit_button_pressed():
	Game.quit()

func _on_again_button_pressed():
	Game.restart()

func _on_visibility_changed():
	print("Setting the complete scene ["+str(visible)+"]")
	print("Game.won ["+str(Game.won)+"]")
	$ScoreLabel.text = "You scored " + str(Game.score) + " points!"
	if Game.won:
		$OutcomeLabel.text = "Yay! You won!"
	else:
		$OutcomeLabel.text = "Oh no! You lost! :("
