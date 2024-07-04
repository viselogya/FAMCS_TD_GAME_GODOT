extends Node2D

var Enemies = [
	preload("res://Enemies/EnemyDinosaur.tscn"),
	preload("res://Enemies/EnemyRobot.tscn"),
	preload("res://Enemies/EnemyStoneGolem.tscn"),
	preload("res://Enemies/EnemySkeleton.tscn"),
	preload("res://Enemies/EnemyKnight.tscn")]


@onready var EnemyPath = get_parent().get_node("EnemyPath")
@onready var SpawnTimer = $SpawnTimer
@onready var CurrentLevel = get_parent()
@onready var WavesLabel = get_parent().get_node("Control/HBoxContainer/Waves_label")


@export var quantity_enemies_in_level = 10
var enemies_in_wave_left = quantity_enemies_in_level

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnTimer.start()
	update_waves_label()
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func random_choice(array):
	array.shuffle()
	return array.front()
	
func add_enemy():
	var enemy = random_choice(Enemies).instantiate()
	EnemyPath.add_child(enemy)
	enemy.iam_on_end.connect(CurrentLevel.enemy_on_end)
	enemies_in_wave_left -= 1
	update_waves_label()

func _on_spawn_timer_timeout():
	if enemies_in_wave_left > 0:
		add_enemy()
		var time_delay = randi() % 2
		print(time_delay)
		SpawnTimer.start(time_delay)

func update_waves_label():
	WavesLabel.set_text("Enemies left: " + str(enemies_in_wave_left))
