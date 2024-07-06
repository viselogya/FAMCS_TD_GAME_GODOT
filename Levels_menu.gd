extends Node2D

func _on_go_to_level_1_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_go_to_level_2_pressed():
	get_tree().change_scene_to_file("res://Towers/level_2.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Towers/level_3.tscn")


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
