extends Node2D

var button_child
var label_child
var orders = ["plate_cooked_seaweed", "plate_cooked_seaweed"]
var orders_string

# Called when the node enters the scene tree for the first time.
func _ready():
	button_child = get_child(0)
	label_child = get_child(1)
	
	orders_string = ''
	for i in orders:
		orders_string = orders_string + i + '\n'
	label_child.text = orders_string

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		#if something is dropped onto this pan

		#check if the thing is in the order list
		var dropped_thing_index = orders.find(SceneManager.currentlyHeld.itemName)
		
		if (dropped_thing_index != - 1):
			#remove item from orders
			orders.pop_at(dropped_thing_index)

			#empty the origin plate
			SceneManager.currentlyHeld.empty_plate()

			#update orders
			orders_string = ''
			for i in orders:
				orders_string = orders_string + i + '\n'
			label_child.text = orders_string

			if (orders.size() == 0):
				self.queue_free()

			print(orders)
