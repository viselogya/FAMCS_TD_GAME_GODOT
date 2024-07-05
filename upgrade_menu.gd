extends HBoxContainer

signal cell()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func _on_cell_pressed():
	cell.emit()
