extends Button

@export_file var level_path

func _on_mouse_entered():
	$Hitsound.play()


func _on_pressed():
	if level_path == null:
		return
	get_tree().change_scene_to_file(level_path)
