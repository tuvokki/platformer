extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	Game.start()

func _input(event):	
	if(event.is_action("ui_accept")) and !Game.running:
		Game.start()
