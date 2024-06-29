extends PathFollow2D

# Настроим скорость движения
@export var speed = 100.0
# Переменная для хранения предыдущей позиции
var previous_position: Vector2

# Ссылка на AnimatedSprite
@onready var animated_sprite = $Dinosaur

func _ready():
	previous_position = global_position

func _process(delta):

	set_progress(get_progress() + speed * delta)

	var current_position = global_position
	var direction = current_position - previous_position
	
	previous_position = current_position

	if direction.length() > 0:
		direction = direction.normalized()
		if abs(direction.x) > abs(direction.y):
			if direction.x >= 0:
				animated_sprite.play("right")
			else:
				animated_sprite.play("left")
		else:
			animated_sprite.play("right")
	else:
		defeat()

func defeat():
	queue_free()
