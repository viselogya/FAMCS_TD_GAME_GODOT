extends HBoxContainer

@onready var score_label = $Score_label
@onready var waves_label = $Waves_label
@onready var exit_button = $Exit_button
	
func change_waves_label(new_waves):
	waves_label.set_text("Enemies left: " + str(new_waves))

func _on_exit_button_pressed():
	get_tree().quit()
