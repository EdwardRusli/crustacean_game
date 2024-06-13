extends Node2D
@export var itemName: String;
@export var itemType: String;
var button_child

var coconut_umbrellablue = preload ("res://sprites/coconut_umbrellablue.png")
var coconut_umbrellapink = preload ("res://sprites/coconut_umbrellapink.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (itemName == "coconut"&&Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		if (SceneManager.currentlyHeld.itemName == "umbrellablue"):
			itemName = "coconut_umbrellablue"
			button_child.texture_normal = coconut_umbrellablue
		if (SceneManager.currentlyHeld.itemName == "umbrellapink"):
			itemName = "coconut_umbrellapink"
			button_child.texture_normal = coconut_umbrellapink
		
		#if something is dropped onto this item

func _on_texture_button_button_down():
	if (SceneManager.currentlyHeld == null):
		SceneManager.currentlyHeld = self
		print(SceneManager.currentlyHeld.itemName)
	pass # Replace with function body.
