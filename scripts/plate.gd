extends Node2D

var button_child

var itemType = "plate"
var itemName = "plate_empty"

var empty_plate_texture = preload ("res://sprites/plate/plate 192.png")

var plate_tortilla = preload ("res://sprites/taco/taco empty.png")
var plate_tortilla_kelp = preload ("res://sprites/taco/taco kelp/taco kelp.png")
var plate_tortilla_kelp_mayo = preload ("res://sprites/taco/taco kelp/taco kelp mayo.png")
var plate_tortilla_kelp_salsa = preload ("res://sprites/taco/taco kelp/taco kelp salsa.png")

var plate_tortilla_meat = preload ("res://sprites/taco/taco meat/taco meat.png")
var plate_tortilla_meat_mayo = preload ("res://sprites/taco/taco meat/taco meat mayo.png")
var plate_tortilla_meat_salsa = preload ("res://sprites/taco/taco meat/taco meat salsa.png")

var plate_tortilla_kelpmeat = preload ("res://sprites/taco/taco meat kelp/taco meat kelp.png")
var plate_tortilla_kelpmeat_mayo = preload ("res://sprites/taco/taco meat kelp/taco meat kelp mayo.png")
var plate_tortilla_kelpmeat_salsa = preload ("res://sprites/taco/taco meat kelp/taco meat kelp salsa.png")

#sandwich
var plate_bread = preload ("res://sprites/sandwich/sandwhich bread.png")
var plate_bread_cheese = preload ("res://sprites/sandwich/sandwhich cheese raw.png")
var plate_bread_kelp = preload ("res://sprites/sandwich/sandwhich kelp raw.png")
var plate_bread_ham = preload ("res://sprites/sandwich/sandwhich meat raw.png")

var plate_bread_cheese_kelp = preload ("res://sprites/sandwich/sandwhich kelp cheese raw.png")
var plate_bread_cheese_ham = preload ("res://sprites/sandwich/sandwhich meat cheese raw.png")
var plate_bread_kelp_ham = preload ("res://sprites/sandwich/sandwhich kelp meat raw.png")

var plate_bread_full = preload ("res://sprites/sandwich/sandwhich lengkap raw.png")

#cooked sandwich
var plate_bread_cheese_cooked = preload ("res://sprites/sandwich/sandwhich cheese cooked.png")
var plate_bread_kelp_cooked = preload ("res://sprites/sandwich/sandwhich kelp cooked.png")
var plate_bread_ham_cooked = preload ("res://sprites/sandwich/sandwhich meat cooked.png")

var plate_bread_cheese_kelp_cooked = preload ("res://sprites/sandwich/sandwich kelp cheese cooked.png")
var plate_bread_cheese_ham_cooked = preload ("res://sprites/sandwich/sandwhich meat cheese cooked.png")
var plate_bread_kelp_ham_cooked = preload ("res://sprites/sandwich/sandwhich kelp meat cooked.png")

var plate_bread_full_cooked = preload ("res://sprites/sandwich/sandwhich lengkap cooked.png")

var pop_sound = preload ("res://sounds/pop.mp3")
var audio_stream_player

func _ready():
	button_child = get_child(0)
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)

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

		#sandwiches
		if (SceneManager.currentlyHeld.itemName == "bread"&&itemName == "plate_empty"):
			add_item_to_plate(plate_bread, "plate_bread")

		if (SceneManager.currentlyHeld.itemName == "cheese"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_cheese, "plate_bread_cheese")
		if (SceneManager.currentlyHeld.itemName == "ham"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_ham, "plate_bread_ham")
		if (SceneManager.currentlyHeld.itemName == "kelp"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_kelp, "plate_bread_kelp")

		if (SceneManager.currentlyHeld.itemName == "cheese"&&itemName == "plate_bread_ham"):
			add_item_to_plate(plate_bread_cheese_ham, "plate_bread_cheese_ham")
		if (SceneManager.currentlyHeld.itemName == "ham"&&itemName == "plate_bread_cheese"):
			add_item_to_plate(plate_bread_cheese_ham, "plate_bread_cheese_ham")

		if (SceneManager.currentlyHeld.itemName == "cheese"&&itemName == "plate_bread_kelp"):
			add_item_to_plate(plate_bread_cheese_kelp, "plate_bread_cheese_kelp")
		if (SceneManager.currentlyHeld.itemName == "kelp"&&itemName == "plate_bread_cheese"):
			add_item_to_plate(plate_bread_cheese_kelp, "plate_bread_cheese_kelp")

		if (SceneManager.currentlyHeld.itemName == "ham"&&itemName == "plate_bread_kelp"):
			add_item_to_plate(plate_bread_kelp_ham, "plate_bread_kelp_ham")
		if (SceneManager.currentlyHeld.itemName == "kelp"&&itemName == "plate_bread_ham"):
			add_item_to_plate(plate_bread_kelp_ham, "plate_bread_kelp_ham")

		if (SceneManager.currentlyHeld.itemName == "cheese"&&itemName == "plate_bread_kelp_ham"):
			add_item_to_plate(plate_bread_full, "plate_bread_full")
		if (SceneManager.currentlyHeld.itemName == "kelp"&&itemName == "plate_bread_cheese_ham"):
			add_item_to_plate(plate_bread_full, "plate_bread_full")
		if (SceneManager.currentlyHeld.itemName == "ham"&&itemName == "plate_bread_cheese_kelp"):
			add_item_to_plate(plate_bread_full, "plate_bread_full")
		
		#cooked sandwiches
		if (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_cheese_cooked, "plate_bread_cheese_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_kelp_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_kelp_cooked, "plate_bread_kelp_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_ham_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_ham_cooked, "plate_bread_ham_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_kelp_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_cheese_kelp_cooked, "plate_bread_cheese_kelp_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_ham_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_cheese_ham_cooked, "plate_bread_cheese_ham_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_kelp_ham_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_kelp_ham_cooked, "plate_bread_kelp_ham_cooked")
		if (SceneManager.currentlyHeld.itemName == "plate_bread_full_cooked"&&itemName == "plate_bread"):
			add_item_to_plate(plate_bread_full_cooked, "plate_bread_full_cooked")
			
func _on_texture_button_button_down():
	if (itemName != "plate_empty"):
		audio_stream_player.stream = pop_sound
		audio_stream_player.play()
		SceneManager.currentlyHeld = self

func empty_plate():
	print("plate emptied")
	itemName = "plate_empty"
	button_child.texture_normal = empty_plate_texture
