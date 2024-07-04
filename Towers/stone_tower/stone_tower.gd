extends Tower

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	
func get_bullet_scene_path():
	return "res://Towers/stone_tower/stone_bullet.tscn"

func get_type_of_tower():
	return "stone_tower"
