extends Node2D

var coconut_ready
var coconut_instance
@export var coconut_scene: PackedScene
@onready var refill_timer = $RefillTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	coconut_instance = coconut_scene.instantiate()
	add_child(coconut_instance)
	coconut_ready = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass

func take_drink():
	coconut_instance.queue_free()
	coconut_ready = false
	refill_timer.start()

func _on_refill_timer_timeout():
	coconut_instance = coconut_scene.instantiate()
	add_child(coconut_instance)
	coconut_ready = true