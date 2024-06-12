extends Node2D

var button_child
var cooking = false
var finished_cooking = false
var itemName # what is the draggable item name once food is cooked?

var empty_sprite = preload ("res://sprites/pan.png")
var cooking_seaweed = preload ("res://sprites/seaweed_cooking.png")
var cooked_seaweed = preload ("res://sprites/seaweed_cooked.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		#if something is dropped onto this pan
		if (SceneManager.currentlyHeld.itemName == "seaweed"&&!cooking&&!finished_cooking):
			print("seaweed released on pan")
			cooking = true
			#start cooking
			button_child.texture_normal = cooking_seaweed
			var timer = Timer.new()
			timer.wait_time = 3
			timer.one_shot = true
			timer.autostart = true
			timer.timeout.connect(func():
				button_child.texture_normal=cooked_seaweed
				cooking=false
				finished_cooking=true
				itemName="cooked_seaweed"
				)
			add_child(timer)
			
		SceneManager.currentlyHeld = null

func _on_texture_button_button_down():
	if (finished_cooking):
		SceneManager.currentlyHeld = self

func empty_pan():
	print("pan emptied")
	finished_cooking = false
	button_child.texture_normal = empty_sprite