extends Control

var is_paused:bool = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused 

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		is_paused = !is_paused


func _on_resume_button_pressed():
	is_paused = false


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/mainpanel.tscn")
