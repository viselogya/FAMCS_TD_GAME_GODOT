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
@onready var WavesLabel = get_parent().get_node("upper_menu_on_level/Waves_label")
@onready var shop = $"../shop"

@export var quantity_enemies_in_level : int
@onready var enemies_in_wave_left = quantity_enemies_in_level

var enemeis_died : int = 0

func _ready():
	print(quantity_enemies_in_level)
	SpawnTimer.start()
	update_waves_label()
	randomize()


func random_choice(array):
	array.shuffle()
	return array.front()
	
func add_enemy():
	var enemy = random_choice(Enemies).instantiate()
	EnemyPath.add_child(enemy)
	enemy.iam_on_end.connect(CurrentLevel.enemy_on_end)
	enemy.iam_dead.connect(shop.update_balance)
	enemy.iam_dead_for_spawner.connect(enemy_died)
	enemy.iam_on_end_for_spawner.connect(enemy_died)
	enemies_in_wave_left -= 1
	update_waves_label()

func enemy_died():
	enemeis_died += 1
	if enemeis_died == quantity_enemies_in_level:
		get_tree().change_scene_to_file("res://winner_scene.tscn")

func _on_spawn_timer_timeout():
	if enemies_in_wave_left > 0:
		add_enemy()
		var time_delay = randi() % 3 + 1
		SpawnTimer.start(time_delay)

func update_waves_label():
	WavesLabel.set_text("Enemies left: " + str(enemies_in_wave_left))
