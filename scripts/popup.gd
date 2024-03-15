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
	
func show_results():
	popup_centered()
	
	
func _on_close_requested():
	hide()
	get_tree().change_scene_to_file("res://scenes/mainpanel.tscn")


func _on_next_level_button_pressed():
	pass


func _on_repeat_level_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
