extends Node2D

var button_child

var itemType = "plate"
var itemName = "plate_empty"

var empty_plate_texture = preload ("res://sprites/plate.png")

var plate_tortilla = preload ("res://sprites/plate_tortilla.png")
var plate_tortilla_kelp = preload ("res://sprites/plate_tortilla_kelp.png")
var plate_tortilla_kelp_mayo = preload ("res://sprites/plate_tortilla_kelp_mayo.png")
var plate_tortilla_kelp_salsa = preload ("res://sprites/plate_tortilla_kelp_salsa.png")

var plate_tortilla_meat = preload ("res://sprites/plate_tortilla_meat.png")
var plate_tortilla_meat_mayo = preload ("res://sprites/plate_tortilla_meat_mayo.png")
var plate_tortilla_meat_salsa = preload ("res://sprites/plate_tortilla_meat_salsa.png")

var plate_tortilla_kelpmeat = preload ("res://sprites/plate_tortilla_kelpmeat.png")
var plate_tortilla_kelpmeat_mayo = preload ("res://sprites/plate_tortilla_kelpmeat_mayo.png")
var plate_tortilla_kelpmeat_salsa = preload ("res://sprites/plate_tortilla_kelpmeat_salsa.png")

func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

func add_item_to_plate(new_texture, new_name):
			button_child.texture_normal = new_texture
			#SceneManager.currentlyHeld.empty_pan()
			itemName = new_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		#if something is dropped onto this plate
		if (SceneManager.currentlyHeld.itemName == "tortilla"&&itemName == "plate_empty"):
			add_item_to_plate(plate_tortilla, "plate_tortilla")

		#kelp
		if (SceneManager.currentlyHeld.itemName == "cooked_kelp"&&itemName == "plate_tortilla"):
			add_item_to_plate(plate_tortilla_kelp, "plate_tortilla_kelp")
			SceneManager.currentlyHeld.empty_pan()

		if (SceneManager.currentlyHeld.itemName == "mayo"&&itemName == "plate_tortilla_kelp"):
			add_item_to_plate(plate_tortilla_kelp_mayo, "plate_tortilla_kelp_mayo")

		if (SceneManager.currentlyHeld.itemName == "salsa"&&itemName == "plate_tortilla_kelp"):
			add_item_to_plate(plate_tortilla_kelp_salsa, "plate_tortilla_kelp_salsa")

		#meat
		if (SceneManager.currentlyHeld.itemName == "cooked_meat"&&itemName == "plate_tortilla"):
			add_item_to_plate(plate_tortilla_meat, "plate_tortilla_meat")
			SceneManager.currentlyHeld.empty_pan()

		if (SceneManager.currentlyHeld.itemName == "mayo"&&itemName == "plate_tortilla_meat"):
			add_item_to_plate(plate_tortilla_meat_mayo, "plate_tortilla_meat_mayo")

		if (SceneManager.currentlyHeld.itemName == "salsa"&&itemName == "plate_tortilla_meat"):
			add_item_to_plate(plate_tortilla_meat_salsa, "plate_tortilla_meat_salsa")

		#kelp+meat
		if (SceneManager.currentlyHeld.itemName == "cooked_meat"&&itemName == "plate_tortilla_kelp"):
			add_item_to_plate(plate_tortilla_kelpmeat, "plate_tortilla_kelpmeat")
			SceneManager.currentlyHeld.empty_pan()
		if (SceneManager.currentlyHeld.itemName == "cooked_kelp"&&itemName == "plate_tortilla_meat"):
			add_item_to_plate(plate_tortilla_kelpmeat, "plate_tortilla_kelpmeat")
			SceneManager.currentlyHeld.empty_pan()

		if (SceneManager.currentlyHeld.itemName == "mayo"&&itemName == "plate_tortilla_kelpmeat"):
			add_item_to_plate(plate_tortilla_kelpmeat_mayo, "plate_tortilla_kelpmeat_mayo")

		if (SceneManager.currentlyHeld.itemName == "salsa"&&itemName == "plate_tortilla_kelpmeat"):
			add_item_to_plate(plate_tortilla_kelpmeat_salsa, "plate_tortilla_kelpmeat_salsa")
			
func _on_texture_button_button_down():
	if (itemName != "plate_empty"):
		SceneManager.currentlyHeld = self

func empty_plate():
	print("plate emptied")
	itemName = "plate_empty"
	button_child.texture_normal = empty_plate_texture
