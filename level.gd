extends Node2D

var Enemies = [
	preload("res://Enemies/EnemyDinosaur.tscn"),
	preload("res://Enemies/EnemyRobot.tscn"),
	preload("res://Enemies/EnemyStoneGolem.tscn"),
	preload("res://Enemies/EnemySkeleton.tscn"),
	preload("res://Enemies/EnemyKnight.tscn")]

var Towers = [
	preload("res://Towers/wooden_tower.tscn"),
	preload("res://Towers/stone_tower/stone_tower.tscn"),
	preload("res://eifel_tower.tscn"),
	preload("res://Towers/jade_tower.tscn")
]
var tower_number : int

@onready var build_zone = $build_zone
@onready var shop = $shop
@onready var music_game_over = $music_game_over

var build_mode = false
var build_cells = []

var base_hp = 5

func _ready():
	shop.wooden_tower_signal.connect(create_wooden_tower)
	shop.stone_tower_signal.connect(create_stone_tower)
	shop.eifel_tower_signal.connect(create_eifel_tower)
	shop.jade_tower_signal.connect(create_jade_tower)
	randomize()
	build_cells = build_zone.get_used_cells(0)

func _unhandled_input(event):
	if build_mode == true:
		if event is InputEventScreenTouch and event.is_pressed():
			var clicked_cell = build_zone.local_to_map(to_local(event.get_position()))
			if clicked_cell in build_cells:
				var tower = Towers[tower_number].instantiate()
				write_off_money_from_balance()
				tower.set_position(build_zone.map_to_local(clicked_cell) + Vector2(-48, -48))
				build_cells.erase(clicked_cell)
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
	match tower_number:
		0:
			shop.update_balance(shop.wooden_tower_price)
		1:
			shop.update_balance(shop.stone_tower_price)
		2:
			shop.update_balance(shop.eifel_tower_price)
		3:
			shop.update_balance(shop.jade_tower_price)

func enemy_on_end():
	base_hp -= 1
	if base_hp == 0:
		get_tree().change_scene_to_file("res://game_over_scene.tscn")

func write_off_money_from_balance():
	match tower_number:
		0:
			shop.update_balance(-shop.wooden_tower_price)
		1:
			shop.update_balance(-shop.stone_tower_price)
		2:
			shop.update_balance(-shop.eifel_tower_price)
		3:
			shop.update_balance(-shop.jade_tower_price)

func create_wooden_tower():
	tower_number = 0
	switch_build_mode()

func create_stone_tower():
	tower_number = 1
	switch_build_mode()

func create_eifel_tower():
	tower_number = 2
	switch_build_mode()

func create_jade_tower():
	tower_number = 3
	switch_build_mode()

func _on_to_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
