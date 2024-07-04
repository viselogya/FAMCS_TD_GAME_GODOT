extends Node2D


signal wooden_tower_signal()
signal eifel_tower_signal()
signal stone_tower_signal()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_wooden_touch_screen_pressed():
	wooden_tower_signal.emit()


func _on_eifel_touch_screen_pressed():
	eifel_tower_signal.emit()


func _on_stone_touch_screen_pressed():
	stone_tower_signal.emit()
