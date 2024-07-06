extends Node2D

@onready var music_winner = $music_winner

func _ready():
	music_winner.play()

func _on_back_to_menu_pressed():
	music_winner.stop()
	get_tree().change_scene_to_file("res://menu.tscn")
