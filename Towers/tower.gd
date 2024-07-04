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

@onready var bullet_scenes = [preload("res://Towers/wooden_bullet.tscn")]
var bullet_scene
var tower_type

func get_bullet_scene_path() -> String:
	return ""

func get_type_of_tower() -> String:
	return ""

func _ready():
	$upgrade_menu.update.connect(_on_upgrade_pressed)
	$upgrade_menu.cell.connect(_on_cell_pressed)
	tower_type = get_type_of_tower()
	bullet_scene = load(get_bullet_scene_path())
	
		
func _process(delta):
	if watching_enemies.is_empty() == false:
		current_state = states.ACTIVE
		$animation_tower.set_animation("active")
		if loaded == true:
			shoot(watching_enemies[0])
	else:
		current_state = states.PASSIVE
		$animation_tower.set_animation("passive")

func shoot(attack_obj : Enemy):
	var bullet = bullet_scene.instantiate()
	match tower_type:
		"wooden_tower":
			add_child(bullet)
			bullet.global_position = bullet.global_position
			bullet.shoot_towards(attack_obj.global_position, attack_obj, level_of_tower)
		"stone_tower":
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
