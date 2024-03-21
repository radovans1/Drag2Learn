@tool
extends PanelContainer
class_name Slot

@export var piece: Piece
@export var is_source: bool

@onready var texture_rect:TextureRect = $TextureRect
@onready var label:Label = $Label
@onready var sound_player = $SoundPlayer

signal animal_dropped(is_correct)
#signal animal_dropped(is_correct, message_texture)

func _ready() -> void:
	update_piece()


func set_piece(p: Piece) -> void:
	piece = p
	update_piece()

func update_piece():
	if piece != null:
		if is_source:
			label.text = ""
			texture_rect.texture = piece.texture
		else:
			label.text = piece.label
	else:
		label.text = ""
		texture_rect.texture = null
	

func _get_drag_data(_at_position):
	if not is_source:
		return null
	
	set_drag_preview(get_preview())
	return piece

func _can_drop_data(_at_position, data):
	return data is Piece

func _drop_data(_at_position, data):
	var dropped_piece: Piece = data as Piece
	
	#if piece != null:
		#if dropped_piece.key == piece.key:
			#texture_rect.texture = dropped_piece.texture
			#label.text = ""
			#var correct_texture = preload("res://assets/character/character vector 1.1.png")
			#emit_signal("animal_dropped", true, correct_texture)
			#show_correct_message("Correct!", correct_texture)
		#else:
			#var incorrect_texture = preload("res://assets/character/character vector tongue.png")
			#emit_signal("animal_dropped", false, incorrect_texture)
			##flash_warning_color()
			#show_warning_message("Wrong, Try again!", incorrect_texture)
	
	if piece != null:
		if dropped_piece.key == piece.key:
			texture_rect.texture = dropped_piece.texture
			label.text = ""
			#var correct_texture = preload("res://assets/character/character vector 1.1.png")
			if piece.sound:
				sound_player.stream = piece.sound
				sound_player.play()
			emit_signal("animal_dropped", true)
			show_correct_message("Correct!")
		else:
			#var incorrect_texture = preload("res://assets/character/character vector tongue.png")
			emit_signal("animal_dropped", false)
			#flash_warning_color()
			show_warning_message("Wrong, Try again!")
	
	
func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1        # get bigger picture after drag
	preview_texture.size = Vector2(120,120)
	
	# Count pivot offset to be in the centre of preview 
	var pivot_offset = preview_texture.size / 2.0
	
	#Center preview on cursor in the middle
	preview_texture.pivot_offset = pivot_offset
	preview_texture.position = -pivot_offset
	
	# new Consol node for preview
	var preview = Control.new() 
	# add TextureRect to new Consol node
	preview.add_child(preview_texture) 
	
	return preview
	
 #Called when piece is dropped on wrong place 
#func show_warning_message(message: String, texture: Texture):
func show_warning_message(message: String):
	var warning_label = $"../../../WarningLabel"
	#var message_image = $"../../../CorrectMessageImage"
	warning_label.text = message
	#message_image.texture = texture
	warning_label.visible = true
	#message_image.visible = true
	await get_tree().create_timer(2.0).timeout
	warning_label.visible = false
	#message_image.visible = false

#func show_correct_message(message: String, texture: Texture):
func show_correct_message(message: String):
	var correct_label = $"../../../CorrectLabel"
	#var message_image = $"../../../IncorrectMessageImage"
	correct_label.text = message
	#message_image.texture = texture
	correct_label.visible = true
	#message_image.visible = true
	await get_tree().create_timer(2.0).timeout
	correct_label.visible = false
	#message_image.visible = false


#func flash_warning_color():
	#var initial_color = texture_rect.modulate  # Uložiť pôvodnú farbu
	#texture_rect.modulate = Color.RED  # Zmeniť farbu na červenú
	#await get_tree().create_timer(0.5).timeout  # Počkať pol sekundy
	#texture_rect.modulate = initial_color  # Vrátiť pôvodnú farbu


