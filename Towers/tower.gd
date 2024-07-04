extends Node2D

class_name Tower

enum states {
	PASSIVE,
	ACTIVE,
}

signal tower_is_cell(cell_position)

var current_state = states.PASSIVE
@export var level_of_tower: int = 0
@export var reload_time: float

var loaded = true
var watching_enemies = []

@onready var reload_timer = $reload_timer 

var bullet_scene = preload("res://Towers/wooden_bullet.tscn")

var tower_scene = preload("res://Towers/wooden_tower/wooden_tower.tscn")


func _ready():
	$upgrade_menu.update.connect(_on_upgrade_pressed)
	$upgrade_menu.cell.connect(_on_cell_pressed)
		

func _process(delta):
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
	bullet.shoot_towards(attack_obj.global_position, attack_obj, level_of_tower)

	loaded = false
	reload_timer.start(reload_time)

func _on_visibility_radius_area_entered(area):
	watching_enemies.append(area.get_parent())

func _on_visibility_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())

func _on_reload_timer_timeout():
	loaded = true

func _on_cell_pressed():
	tower_is_cell.emit(get_global_position())
	queue_free()
	
func _on_upgrade_pressed():
	if level_of_tower <= 4:
		level_of_tower += 1
	else:
		$upgrade_menu/upgrade.set_disabled(true)
	$upgrade_menu.set_visible(false)

func _on_upgrade_menu_button_pressed():
	if $upgrade_menu.is_visible() == true:
		$upgrade_menu.set_visible(false)
	else:
		$upgrade_menu.set_visible(true)
