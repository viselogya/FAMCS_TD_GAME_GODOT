extends Node2D

func _on_exit_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels_menu.tscn")

func _on_setting_button_pressed():
	pass

func _on_exit_button_pressed():
	get_tree().quit()
