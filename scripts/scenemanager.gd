extends Control
var currentlyHeld = null
signal successfully_dropped
signal continue_dialogue

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	call_deferred("release")
	
	pass
	
func release():
	if Input.is_action_just_released("mouse_left"):
		if (currentlyHeld != null):
			currentlyHeld = null
			print("released")
