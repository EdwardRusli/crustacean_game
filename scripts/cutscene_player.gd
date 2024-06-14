extends Node2D

@export var timelineName: String
@export var level_to_load_after: String
#@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)

	#animation_player.play("CutsceneStart")
	#await get_tree().create_timer(1).timeout

	Dialogic.start(timelineName)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeline_ended():
	get_tree().change_scene_to_file(level_to_load_after)
	#animation_player.play("CutsceneEnd")