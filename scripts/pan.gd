extends Node2D

var button_child
var cooking = false
var finished_cooking = false
var itemName # what is the draggable item name once food is cooked?
var itemType = "pan"

var empty_sprite = preload ("res://sprites/pan.png")

var cooking_kelp = preload ("res://sprites/taco/kelp raw.png")
var cooked_kelp = preload ("res://sprites/taco/kelp cooked.png")

var cooking_meat = preload ("res://sprites/taco/meat.png")
var cooked_meat = preload ("res://sprites/meat_cooked.png") # PENDING

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
var sizzle_sound = preload ("res://sounds/sizzle.mp3")
var audio_stream_player

func _ready():
	button_child = get_child(0)
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	pass # Replace with function body.

func _cook_if_can(cook_time: float, cooking_texture, cooked_texture, result_name):
	if (!cooking&&!finished_cooking):
		audio_stream_player.stream = sizzle_sound
		audio_stream_player.play()
		cooking = true
		#start cooking
		button_child.texture_normal = cooking_texture
		var timer = Timer.new()
		timer.wait_time = cook_time
		timer.one_shot = true
		timer.autostart = true
		timer.timeout.connect(func():
			button_child.texture_normal=cooked_texture
			cooking=false
			finished_cooking=true
			itemName=result_name
			)
		add_child(timer)
	SceneManager.currentlyHeld = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		#if something is dropped onto this pan

		#cooking recipe for kelp
		if (SceneManager.currentlyHeld.itemName == "kelp"):
			_cook_if_can(3, cooking_kelp, cooked_kelp, "cooked_kelp")
		#cooking recipe for meat
		elif (SceneManager.currentlyHeld.itemName == "meat"):
			_cook_if_can(4, cooking_meat, cooked_meat, "cooked_meat")

		#cooking recipe for bread
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_cooked"): _cook_if_can(5, plate_bread_cheese, plate_bread_cheese_cooked, "plate_bread_cheese_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_kelp_cooked"): _cook_if_can(5, plate_bread_kelp, plate_bread_kelp_cooked, "plate_bread_kelp_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_ham_cooked"): _cook_if_can(5, plate_bread_ham, plate_bread_ham_cooked, "plate_bread_ham_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_kelp_cooked"): _cook_if_can(5, plate_bread_cheese_kelp, plate_bread_cheese_kelp_cooked, "plate_bread_cheese_kelp_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_cheese_ham_cooked"): _cook_if_can(5, plate_bread_cheese_ham, plate_bread_cheese_ham_cooked, "plate_bread_cheese_ham_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_kelp_ham_cooked"): _cook_if_can(5, plate_bread_kelp_ham, plate_bread_kelp_ham_cooked, "plate_bread_kelp_ham_cooked")
		elif (SceneManager.currentlyHeld.itemName == "plate_bread_full_cooked"): _cook_if_can(5, plate_bread_full, plate_bread_full_cooked, "plate_bread_full_cooked")

func _on_texture_button_button_down():
	if (finished_cooking):
		audio_stream_player.stream = pop_sound
		audio_stream_player.play()
		SceneManager.currentlyHeld = self

func empty_pan():
	print("pan emptied")
	finished_cooking = false
	button_child.texture_normal = empty_sprite
