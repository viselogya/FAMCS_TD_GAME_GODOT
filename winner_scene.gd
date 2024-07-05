extends Node2D

@onready var music_winner = $music_winner

func _on_back_to_menu_pressed():
	music_winner.play()
	get_tree().change_scene_to_file("res://menu.tscn")
