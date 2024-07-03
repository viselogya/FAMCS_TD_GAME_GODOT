extends Node2D

var Enemies = [
	preload("res://Enemies/EnemyDinosaur.tscn"),
	preload("res://Enemies/EnemyRobot.tscn"),
	preload("res://Enemies/EnemyStoneGolem.tscn")]

var Towers = [
	preload("res://Towers/wooden_tower/wooden_tower.tscn")
]


@onready var build_zone = $build_zone

var build_mode = false
var build_cells = []


func _ready():
	randomize()
	build_cells = build_zone.get_used_cells(0)
	print(build_cells)


func _unhandled_input(event):
	if build_mode == true:
		if event is InputEventScreenTouch and event.is_pressed():
			var clicked_cell = build_zone.local_to_map(to_local(event.get_position()))
			if clicked_cell in build_cells:
				var tower = Towers[0].instantiate()
				tower.set_position(build_zone.map_to_local(clicked_cell) + Vector2(-48, -48))
				build_cells.erase(clicked_cell)
				print(build_cells)
				add_child(tower)
				tower.tower_is_cell.connect(_restore_cell_for_build)
				switch_build_mode()
				

func random_choice(array):
	array.shuffle()
	return array.front()

func add_enemy():
	var enemy = random_choice(Enemies).instantiate()

	$EnemyPath.add_child(enemy)

func _on_waves_timer_timeout():
	add_enemy()

func _on_build_mode_pressed():
	switch_build_mode()
	
func switch_build_mode():
	if build_mode == false:
		build_mode = true
	else:
		build_mode = false	
	$build_zone.set_visible(build_mode)

func _restore_cell_for_build(local_pos):
	build_cells.append(build_zone.local_to_map(to_local(local_pos)))


func _on_wooden_touch_screen_pressed():
	pass # Replace with function body.
