extends Node

var diamond: StaticBody2D = preload("res://scenes/diamond.tscn").instantiate()
@onready var game_root: Node = get_tree().root.get_node("GameRoot")
@onready var world: Node = game_root.get_node("World")
@onready var diamonds: Node = world.get_node("Diamonds")
@onready var score_label: Label = game_root.get_node("Stats").get_node("Score")
@onready var key_warning_label: Label = game_root.get_node("Stats").get_node("KeyWarning")

var score = 0
var has_key = false
var won = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func add_score():
	score += 1
	score_label.text = "Score: " + str(score)

func add_key():
	has_key = true

func add_lock():
	if has_key:
		won = true
		get_tree().change_scene_to_file("res://scenes/LevelComplete.tscn")
	else:
		key_warning_label.visible = true
		await get_tree().create_timer(1.0).timeout
		key_warning_label.visible = false

func lost():
	get_tree().change_scene_to_file("res://scenes/LevelComplete.tscn")

func restart():
	pass
	#var score_label: Label = game_root.get_node("Stats").get_node("Score")
	#get_tree().change_scene_to_file("res://scenes/game_root.tscn")

func get_random_position():
	var screenSize = get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, screenSize.x)
	var rndY = rng.randi_range(0, screenSize.y)
	return Vector2(rndX, rndY)
