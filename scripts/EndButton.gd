extends Button

func _on_mouse_entered():
	$Hitsound.play()

func _on_pressed():
	get_tree().quit()
