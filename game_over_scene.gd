extends Node2D

@onready var music_game_over = $music_game_over

func _ready():
	music_game_over.play()

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
