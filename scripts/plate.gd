extends Node2D

var button_child

var occupied = false
var itemName

var empty_plate_texture = preload ("res://sprites/plate.png")
var plate_cooked_seaweed = preload ("res://sprites/plate_cooked_seaweed.png")

func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null&&!occupied):
		#if something is dropped onto this plate
		if (SceneManager.currentlyHeld.itemName == "cooked_seaweed"):
			print("seaweed dropped on plate")
			button_child.texture_normal = plate_cooked_seaweed
			SceneManager.currentlyHeld.empty_pan()
			itemName = "plate_cooked_seaweed"
			occupied = true

func _on_texture_button_button_down():
	if (occupied):
		SceneManager.currentlyHeld = self

func empty_plate():
	print("plate emptied")
	occupied = false
	button_child.texture_normal = empty_plate_texture
