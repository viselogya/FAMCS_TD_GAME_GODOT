extends PathFollow2D

# Настроим скорость движения
@export var speed = 100.0

func _ready():
	pass

func _process(delta):
	set_progress(get_progress() + speed * delta)
	
	if get_progress_ratio() == 1:
		queue_free()
		
