extends Node2D

var button_child
var cooking = false
var finished_cooking = false
var itemName # what is the draggable item name once food is cooked?
var itemType = "pan"

var empty_sprite = preload ("res://sprites/pan.png")

var cooking_kelp = preload ("res://sprites/kelp_cooking.png")
var cooked_kelp = preload ("res://sprites/kelp_cooked.png")

var cooking_meat = preload ("res://sprites/meat_cooking.png")
var cooked_meat = preload ("res://sprites/meat_cooked.png")

func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

func _cook_if_can(cook_time: float, cooking_texture, cooked_texture, result_name):
	if (!cooking&&!finished_cooking):
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
		elif (SceneManager.currentlyHeld.itemName == "meat"):
			_cook_if_can(4, cooking_meat, cooked_meat, "cooked_meat")
		
		#cooking recipe for meat

func _on_texture_button_button_down():
	if (finished_cooking):
		SceneManager.currentlyHeld = self

func empty_pan():
	print("pan emptied")
	finished_cooking = false
	button_child.texture_normal = empty_sprite
