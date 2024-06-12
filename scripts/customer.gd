extends Node2D

@onready var button: TextureButton = $TextureButton
@onready var test_label: Label = $Label
@onready var dialogue_bubble: Node2D = $DialogueBubble
@onready var dialogue_timer: Timer = $DialogueTimer

signal on_order_received
signal on_all_orders_finished

var orders: Array[String] = ["plate_cooked_seaweed", "plate_cooked_seaweed"]
#var orders: Array[String]
var orders_string # plaintext of orders

var current_line
var dialogue_lines: Array[String] = [
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
	"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
	"According to all known laws of aviation, there is no way that a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyways. Because bees don't care what humans think is impossible."
]
#var dialogue_lines: Array[String]

var dialogue_breakpoints: Array[int] = [
	#which lines does it want to get stuck on? (don't autoscroll after this line) (0 based)
	1
]

# Called when the node enters the scene tree for the first time.
func _ready():
	button = get_child(0)
	test_label = get_child(1)
	
	orders_string = ''
	for i in orders:
		orders_string = orders_string + i + '\n'
	test_label.text = orders_string
	
	await get_tree().create_timer(2.0).timeout

	dialogue_bubble.current_line_finished_typing.connect(_on_dialogue_line_finished_printing)

	dialogue_bubble.lines = dialogue_lines
	dialogue_bubble.show()
	current_line = 0
	dialogue_bubble.print_dialogue(current_line)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button.is_hovered()&&SceneManager.currentlyHeld != null):
		#if something is dropped onto this pan

		#check if the thing is in the order list
		var dropped_thing_index = orders.find(SceneManager.currentlyHeld.itemName)
		
		if (dropped_thing_index != - 1): # if it is a valid item
			#remove item from orders
			orders.pop_at(dropped_thing_index)

			#empty the origin plate
			SceneManager.currentlyHeld.empty_plate()

			on_order_received.emit()

			#update orders
			orders_string = ''
			for i in orders:
				orders_string = orders_string + i + '\n'
			test_label.text = orders_string
			
			next_line() # fix this asap, if food given before finished yapping, it could skip to next dialogue -> softlock
			
			if (orders.size() == 0):
				on_all_orders_finished.emit()
				queue_free()

			print(orders)

func _on_dialogue_line_finished_printing():
	if (!dialogue_breakpoints.has(dialogue_bubble.curr_line)):
		dialogue_timer.start()

func _on_dialogue_timer_timeout():
	next_line()

func next_line():
	current_line += 1
	dialogue_bubble.print_dialogue(current_line)
