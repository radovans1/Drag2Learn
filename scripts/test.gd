extends Node2D

var animals = [
	preload("res://assets/pieces/cow.tres"),
	preload("res://assets/pieces/dog.tres"),
	preload("res://assets/pieces/sheep.tres"),
	preload("res://assets/pieces/cat.tres"),
	preload("res://assets/pieces/chicken.tres"),
	preload("res://assets/pieces/rabbit.tres"),
	preload("res://assets/pieces/pig.tres"),
	preload("res://assets/pieces/horse.tres"),
	preload("res://assets/pieces/mouse.tres")
]

var score = 0

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


@onready var source_slot:Slot = $UI/slot4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animals.shuffle()
	new_animal()
	source_slot.connect("animal_dropped", Callable(self, "_on_slot_animal_dropped"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_animal():
	var animal = animals.pop_front()
	source_slot.set_piece(animal)

func _on_slot_animal_dropped() -> void:
	add_score(10)
	source_slot.set_piece(null)
	new_animal()
