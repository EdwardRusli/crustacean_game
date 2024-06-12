extends Node2D
@export var cookedItemName: String
@export var cookedItemTexture: Texture
var button_child
var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	button_child = get_child(0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	button_child.texture = cookedItemTexture
