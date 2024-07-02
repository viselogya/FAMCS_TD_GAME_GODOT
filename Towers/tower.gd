extends Node2D

class_name Tower

enum states {
	PASSIVE,
	ACTIVE,
}

var current_state = states.PASSIVE
@export var level: int = 0
@export var reload_time: float

var loaded = true
var watching_enemies = []

@onready var reload_timer = $reload_timer 

var bullet_scene = preload("res://Towers/wooden_bullet.tscn")

func _process(delta): # может быть надо будет переделать
	if watching_enemies.is_empty() == false:
		current_state = states.ACTIVE
		$animation_wooden_tower.set_animation("active")
		if loaded == true:
			shoot(watching_enemies[0])
	else:
		current_state = states.PASSIVE
		$animation_wooden_tower.set_animation("passive")

func shoot(attack_obj : Enemy):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	
	bullet.global_position = bullet.global_position
	bullet.shoot_towards(attack_obj.global_position, attack_obj, level)

	loaded = false
	reload_timer.start(reload_time)

func _on_visibility_radius_area_entered(area):
	watching_enemies.append(area.get_parent())

func _on_visibility_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())

func _on_reload_timer_timeout():
	loaded = true

func _on_cell_pressed():
	queue_free()
	
func _on_upgrade_pressed():
	level += 1

