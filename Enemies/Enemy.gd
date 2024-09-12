extends PathFollow2D

class_name Enemy

signal iam_on_end()
signal iam_dead(amount)
signal iam_dead_for_spawner()
signal iam_on_end_for_spawner()

var previous_position: Vector2

@export var Speed: float: set = set_speed, get = get_speed
var saved_speed
@export var Armor: float: set = set_armor, get = get_armor
@export var Helth: float: set = set_helth, get = get_helth
@export var Gold_on_kill: int: set = set_gold_on_kill, get = get_gold_on_kill

@onready var music_dead_enemy = preload("res://Sounds/music_dead_enemy.tscn").instantiate()

func _ready():
	$unit_stats/Vbox/Speed.set_text("Speed: " + str(Speed))
	$unit_stats/Vbox/Armor.set_text("Armor: " + str(Armor))
	$unit_stats/Vbox/Helth.set_text("Helth: " + str(Helth))
	#$unit_stats.set_visible(false)
	previous_position = global_position
	saved_speed = Speed
	print(saved_speed)
	
func _process(delta):
	set_progress(get_progress() + Speed * delta)
	var current_position = global_position
	var direction = current_position - previous_position
	previous_position = current_position
	
	var sprite = get_child(0)
	EnemyRotation(sprite, direction)
	update_debug_setting()
		
	if get_progress_ratio() == 1:
		enemy_on_end()
	
	if get_helth() == 0:
		enemy_dead()

func enemy_on_end():
	queue_free()
	iam_on_end.emit()
	iam_dead_for_spawner.emit()

func enemy_dead():
	iam_dead.emit(Gold_on_kill)
	iam_dead_for_spawner.emit()
	get_parent().get_parent().add_child(music_dead_enemy)
	queue_free()

func update_debug_setting():
	$unit_stats/Vbox/Speed.set_text("Speed: " + str(Speed))
	$unit_stats/Vbox/Armor.set_text("Armor: " + str(Armor))
	$unit_stats/Vbox/Helth.set_text("Helth: " + str(Helth))

func take_damage(damage_val):
	set_helth(get_helth() - damage_val)

func EnemyRotation(sprite: AnimatedSprite2D, direction: Vector2):
	if direction.length() > 0:
		direction = direction.normalized()
		if abs(direction.x) > abs(direction.y):
			if direction.x >= 0:
				sprite.play("right")
			else:
				sprite.play("left")
		else:
			sprite.play("right")

func get_helth():
	return Helth

func set_helth(new_helth : float):
	Helth = max(new_helth, 0)

func get_armor():
	return Armor

func set_armor(new_armor : float):
	Armor = new_armor

func get_speed():
	return Speed

func set_speed(new_Speed : float):
	Speed = new_Speed

func get_gold_on_kill():
	return Gold_on_kill

func set_gold_on_kill(new_gold : int):
	Gold_on_kill = new_gold
