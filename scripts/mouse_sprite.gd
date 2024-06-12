extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(SceneManager.currentlyHeld != null):
		texture = SceneManager.currentlyHeld.button_child.texture_normal
		position = get_viewport().get_mouse_position()
	else:
		texture = null
	pass
