extends PathFollow2D

class_name Enemy

var previous_position: Vector2

@onready var animated_sprites: Array = []

@export var Speed: float: set = set_speed, get = get_speed
@export var Armor: float: set = set_armor, get = get_armor
@export var Helth: float: set = set_helth, get = get_helth

func _ready():
	$unit_stats/Vbox/Speed.set_text("Speed: " + str(Speed))
	$unit_stats/Vbox/Armor.set_text("Armor: " + str(Armor))
	$unit_stats/Vbox/Helth.set_text("Helth: " + str(Helth))
	
	previous_position = global_position
	for child in get_children():
		if child is AnimatedSprite2D:
			animated_sprites.append(child)

func _process(delta):
	set_progress(get_progress() + Speed * delta)
	var current_position = global_position
	var direction = current_position - previous_position
	previous_position = current_position
	
	for sprite in animated_sprites:
		EnemyRotation(sprite, direction)
		update_debug_setting()
		
	if get_progress_ratio() == 1:
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
