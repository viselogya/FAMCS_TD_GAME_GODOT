extends Node2D

enum states {
	PASSIVE,
	ACTIVE,
}

signal tower_is_cell(cell_position)

var current_state = states.PASSIVE

var loaded = true
var watching_enemies = []

@export var reload_time: float

@onready var laser_line = $laser_line
@onready var music_laser = $laser_line/music_laser

var target

func _ready():
	$upgrade_menu.cell.connect(_on_cell_pressed)
		
func _process(delta):
	if watching_enemies.is_empty() == false:
		current_state = states.ACTIVE
		if music_laser.is_playing() == false:
			music_laser.play()
		$animation_tower.set_animation("active")
		shoot(watching_enemies[0])
	else:
		current_state = states.PASSIVE
		$animation_tower.set_animation("passive")
		music_laser.stop()

func shoot(attack_obj : Enemy):
	target = attack_obj
	laser_line.shoot_laser(attack_obj)

func _on_visibility_radius_area_entered(area):
	watching_enemies.append(area.get_parent())

func _on_visibility_radius_area_exited(area):
	watching_enemies.erase(area.get_parent())
	if target == area.get_parent():
		laser_line.stop_shooting()

func _on_reload_timer_timeout():
	loaded = true

func _on_cell_pressed():
	tower_is_cell.emit(get_global_position())
	get_tree
	queue_free()
	
func _on_upgrade_menu_button_pressed():
	if $upgrade_menu.is_visible() == true:
		$upgrade_menu.set_visible(false)
	else:
		$upgrade_menu.set_visible(true)
