extends Node2D
@export var itemName: String;

var button_child
# Called when the node enters the scene tree for the first time.
func _ready():
	button_child = get_child(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_button_down():
	if(SceneManager.currentlyHeld == null):
		SceneManager.currentlyHeld = self
		print(SceneManager.currentlyHeld.itemName)
	pass # Replace with function body.
	
