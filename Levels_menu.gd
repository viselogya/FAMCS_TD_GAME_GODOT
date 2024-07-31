extends Node2D

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_third_level_button_pressed():
	get_tree().change_scene_to_file("res://Towers/level_3.tscn")


func _on_second_level_button_pressed():
	get_tree().change_scene_to_file("res://Towers/level_2.tscn")


func _on_first_level_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")
