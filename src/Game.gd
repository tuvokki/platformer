extends Node

#var diamond: StaticBody2D = preload("res://scenes/diamond.tscn").instantiate()
var player: Node = preload("res://scenes/player.tscn").instantiate()

@onready var game_root: Node = get_tree().root.get_node("GameRoot")
# Stats
@onready var score_label: Label = game_root.get_node("Stats").get_node("Score")
@onready var key_warning_label: Label = game_root.get_node("Stats").get_node("KeyWarning")
@onready var start_screen: Node = game_root.get_node("Stats").get_node("Start")
@onready var complete: Node = game_root.get_node("Stats").get_node("LevelComplete")

var level = "Level_001"
var score = 0
var has_key = false
var won = false
var running = false

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
		end()
	else:
		key_warning_label.visible = true
		await get_tree().create_timer(1.0).timeout
		key_warning_label.visible = false

func end():
	await get_tree().create_timer(0.2).timeout
	running = false
	complete.visible = true
	# Free old stuff.
	if player != null:
		player.queue_free()
	var current_level = game_root.get_node_or_null(level)
	if current_level != null:
		current_level.queue_free()

func start():
	var current_level = load("res://scenes/" + level + ".tscn").instantiate()
	game_root.add_child(current_level)
	player = load("res://scenes/player.tscn").instantiate()
	player.position = current_level.get_node("SpawnPoint").position
	game_root.add_child(player)
	start_screen.visible = false
	complete.visible = false
	running = true

func restart():
	score = 0
	score_label.text = "Score: " + str(score)
	has_key = false
	won = false
	start()

func quit():
	get_tree().quit()

func get_random_position():
	var screenSize = get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, screenSize.x)
	var rndY = rng.randi_range(0, screenSize.y)
	return Vector2(rndX, rndY)
