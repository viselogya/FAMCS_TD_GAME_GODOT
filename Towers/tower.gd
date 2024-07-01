extends Node2D

class_name Tower

enum states {
	PASSIVE,
	ACTIVE,
}

var current_state = states.PASSIVE

var watching_enemies = []

func _ready():
	pass # Replace with function body.


func _process(delta): # может быть надо будет переделать
	if watching_enemies.is_empty() == false:
		current_state = states.ACTIVE
		$animation_wooden_tower.set_animation("active")
	else:
		current_state = states.PASSIVE
		$animation_wooden_tower.set_animation("passive")


func _on_visibility_radius_area_entered(area):
	watching_enemies.append(area.get_parent())

func _on_visibility_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())
