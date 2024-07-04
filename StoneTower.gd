extends Tower

signal tower_node(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	tower_node.emit(self)
