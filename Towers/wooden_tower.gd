extends Tower

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	
func get_bullet_scene_path():
	return "res://Towers/wooden_bullet.tscn"

func get_type_of_tower():
	return "wooden_tower"
