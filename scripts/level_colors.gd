extends Node2D

var animals = [
	preload("res://assets/pieces/colors/black.tres"),
	preload("res://assets/pieces/colors/blue.tres"),
	preload("res://assets/pieces/colors/brown.tres"),
	preload("res://assets/pieces/colors/green.tres"),
	preload("res://assets/pieces/colors/orange.tres"),
	preload("res://assets/pieces/colors/pink.tres"),
	preload("res://assets/pieces/colors/red.tres"),
	preload("res://assets/pieces/colors/white.tres"),
	preload("res://assets/pieces/colors/yellow.tres")
]

var score = 0
var correctly_placed = 0
var incorrectly_placed = 0

var popup_panel_instance

@onready var source_slot:Slot = $UI/PieceSlot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animals.shuffle()
	new_animal()
	source_slot.connect("animal_dropped", Callable(self, "_on_slot_animal_dropped"))
	update_score_display()
	popup_panel_instance = $PopupPanel 
	popup_panel_instance.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_animal():
	if animals.is_empty():
		show_game_results()
	else:
		var animal = animals.pop_front()
		source_slot.set_piece(animal)

func _on_slot_animal_dropped(is_correct: bool) -> void:
	if is_correct:
		add_score(10)
		correctly_placed += 1
		source_slot.set_piece(null)			#delete correctly dropped piece 
		new_animal()
	else:
		add_score(-5)
		incorrectly_placed += 1
	#source_slot.set_piece(null)
	#new_animal()
	
#Called for add points to score
func add_score(points: int):
	score+= points
	update_score_display()
	
#Called when points are added to score 	
func update_score_display():
	if $Score/ScoreLabel:
		$Score/ScoreLabel.text = "Score: %d" % score
	else:
		print("Label uzol nebol nájdený")


func show_game_results():
	var correct = correctly_placed - incorrectly_placed
	var incorrect = incorrectly_placed
	popup_panel_instance.setup(correct, incorrect, score)
	popup_panel_instance.show_results()
	

