extends Node2D

@export var speed: float = 1200.0
@export var damage: float = 250.0

var velocity = Vector2.ZERO

@onready var EnemyObj : Enemy

func shoot_towards(target_position: Vector2, Enemy_target : Enemy):
	# Вычисляем направление и скорость
	velocity = (target_position - global_position).normalized() * speed
	EnemyObj = Enemy_target

func _process(delta):
	global_position += velocity * delta
	
	# Удаляем пулю, если она выходит за пределы экрана
	if is_outside_screen():
		queue_free()

func is_outside_screen() -> bool:
	var viewport_rect = get_viewport().get_visible_rect()
	return not viewport_rect.has_point(global_position)


func _on_area_2d_area_entered(area):
	EnemyObj.take_damage(damage)
	queue_free()
