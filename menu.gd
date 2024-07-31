extends Node2D

func _ready():
	get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE

func _on_exit_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels_menu.tscn")

func _on_setting_button_pressed():
	pass

func _on_exit_button_pressed():
	get_tree().quit()
