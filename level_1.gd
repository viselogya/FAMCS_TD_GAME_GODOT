extends Node2D

var Enemy = preload("res://Enemies/EnemyDinosaur.tscn")

func add_enemy():
	var enemy = Enemy.instantiate()
	$EnemyPath.add_child(enemy)

func _on_waves_timer_timeout():
	add_enemy()
