extends Node2D

var Enemies = [
	preload("res://Enemies/EnemyDinosaur.tscn"),
	preload("res://Enemies/EnemyRobot.tscn"),
	preload("res://Enemies/EnemyStoneGolem.tscn"),
	preload("res://Enemies/EnemySkeleton.tscn"),
	preload("res://Enemies/EnemyKnight.tscn")]

var Towers = [
	preload("res://Towers/wooden_tower/wooden_tower.tscn")
]

@onready var build_zone = $build_zone
@onready var shop = $shop

var build_mode = false
var build_cells = []

var tower_number : int

func _ready():
	shop.wooden_tower_signal.connect(create_wooden_tower)
	randomize()
	build_cells = build_zone.get_used_cells(0)

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

func switch_build_mode():
	if build_mode == false:
		build_mode = true
	else:
		build_mode = false	
	$build_zone.set_visible(build_mode)

func _restore_cell_for_build(local_pos):
	build_cells.append(build_zone.local_to_map(to_local(local_pos)))

func enemy_on_end():
	print("Base atacked")

func create_wooden_tower():
	tower_number = 0
	switch_build_mode()

func _on_exit_button_pressed():
	get_tree().quit()
