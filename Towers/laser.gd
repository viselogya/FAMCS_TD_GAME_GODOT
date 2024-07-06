extends Node2D

@export var laser_width: float = 2.0
@export var laser_color: Color = Color(1, 0, 0)
@export var damage = 30.0

var target: Node2D = null
var is_shooting: bool = false

@onready var music_laser = $music_laser

func _ready():
	visible = false
	self.default_color = laser_color
	self.width = laser_width

func shoot_laser(target: Node2D):
	self.target = target
	var cur_pos = Vector2.ZERO
	cur_pos.x += 48
	cur_pos.y += 24
	self.points = [cur_pos, Vector2.ZERO]
	self.visible = true
	is_shooting = true

func stop_shooting():
	self.visible = false
	is_shooting = false
	target = null

func _process(delta: float):
	if is_shooting and target:
		if target.is_inside_tree():
			var local_target_pos = to_local(target.global_position)
			self.points[1] = local_target_pos
		else:
			stop_shooting()


func _on_damage_timer_timeout():
	if target != null:
		target.take_damage(damage)
