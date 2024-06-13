extends Node2D

var button_child

func _ready():
	button_child = get_child(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_released("mouse_left")&&button_child.is_hovered()&&SceneManager.currentlyHeld != null):
		if (SceneManager.currentlyHeld.itemType == "plate"):
			SceneManager.currentlyHeld.empty_plate()
		if (SceneManager.currentlyHeld.itemType == "coconut"):
			SceneManager.currentlyHeld.get_parent().take_drink()
		if (SceneManager.currentlyHeld.itemType == "pan"):
			SceneManager.currentlyHeld.empty_pan()