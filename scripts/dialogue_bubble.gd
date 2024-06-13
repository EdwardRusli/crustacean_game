extends Node2D

@onready var label: Label = $MarginContainer/DialogueLabel
@onready var timer: Timer = $Timer

@export var lines: Array[String]
var curr_line
var curr_letter = 0

signal current_line_finished_typing

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func print_dialogue(line: int):
	#starts dialogue if just beginning, proceeds to next line if currently active
	
	curr_letter = 0
	curr_line = line
	if (curr_line >= lines.size()||curr_line == - 1):
		#if out of lines
		print("out of lines")
		queue_free()
	else:
		label.text = lines[curr_line]
		#begin printing letters
		next_letter()

func next_letter():
	label.visible_characters = curr_letter
	curr_letter += 1
	if (curr_letter >= lines[curr_line].length() + 1):
		#if current line is finished printing
		#print('ended')
		current_line_finished_typing.emit()
		#await get_tree().create_timer(2.0).timeout
		#start_or_next_dialogue()
	else:
		timer.start(0.005)

func _on_timer_timeout():
	next_letter()
