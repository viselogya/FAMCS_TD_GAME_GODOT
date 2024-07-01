extends Node2D

var Enemies = [
	preload("res://Enemies/EnemyDinosaur.tscn"),
	preload("res://Enemies/EnemyRobot.tscn"),
	preload("res://Enemies/EnemyStoneGolem.tscn")]

func _ready():
	randomize()

func random_choice(array):
	array.shuffle()
	return array.front()

func add_enemy():
	var enemy = random_choice(Enemies).instantiate()

	$EnemyPath.add_child(enemy)

func _on_waves_timer_timeout():
	add_enemy()
