extends PathFollow2D

class_name Enemy

var previous_position: Vector2

@onready var animated_sprites: Array = []

@export var Speed = 100.0
@export var Armor = 10.0
@export var Helth = 100.0

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
	
	if get_progress_ratio() == 1:
		queue_free()
		

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
