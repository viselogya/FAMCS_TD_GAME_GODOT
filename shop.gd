extends Node2D


signal wooden_tower_signal()
signal eifel_tower_signal()
signal stone_tower_signal()
signal jade_tower_signal()

@onready var balance_label = $Sprite2D/Control/Balance_label

@export var balance : int = 10

@export var wooden_tower_price = 10
@export var stone_tower_price = 20
@export var eifel_tower_price = 30
@export var jade_tower_price = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	update_balance_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_balance(amount : int):
	balance += amount
	update_balance_label()

func _on_wooden_touch_screen_pressed():
	if balance >= wooden_tower_price:
		wooden_tower_signal.emit()
		update_balance_label()
	else:
		pass

func _on_eifel_touch_screen_pressed():
	if balance >= eifel_tower_price:
		eifel_tower_signal.emit()
		update_balance_label()
	else:
		pass

func _on_stone_touch_screen_pressed():
	if balance >= stone_tower_price:
		stone_tower_signal.emit()
		update_balance_label()
	else:
		pass
		
func _on_jade_touch_screen_pressed():
	if balance >= jade_tower_price:
		jade_tower_signal.emit()
		update_balance_label()
	else:
		pass
	
func update_balance_label():
	balance_label.set_text("Balance: " + str(balance))
