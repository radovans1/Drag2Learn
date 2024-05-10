extends Window

var correct_count = 0
var incorrect_count = 0
var total_score = 0


func _ready():
	hide()
	
func setup(correct: int, incorrect: int, score: int):
	correct_count = correct
	incorrect_count = incorrect
	total_score = score
	
	$HBoxContainer/CorrectCountLabel.text = "Correct answers: %s " % str(correct_count)
	$HBoxContainer/IncorrectCountLabel.text = "Incorrect answers: %s " % str(incorrect_count)
	$HBoxContainer/TotalScoreLabel.text = "Total Score: %s " %str(total_score)
	
	print("Correct: ", correct_count)
	print("Incorrect: ", incorrect_count)
	print("Score: ", total_score)
	
func show_results():
	print("Showing results popup.")
	popup_centered()
	
	
func _on_close_requested():
	print("Closing results popup.")
	hide()
	get_tree().change_scene_to_file("res://scenes/mainpanel.tscn")


func _on_next_level_button_pressed():
	pass


func _on_repeat_level_button_pressed():
	pass

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/select_level_scene.tscn")











