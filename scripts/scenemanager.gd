extends Control
var currentlyHeld = null

@export var customer_scene: PackedScene

var filledSlots = [false, false, false]
var pop_sound = preload ("res://sounds/pop.mp3")

var fed_jelly_fish
var paid_loanshark
var paid_lobstermobster

var audio_stream_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	call_deferred("release")
	
	pass

func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)

func release():
	if Input.is_action_just_released("mouse_left"):
		if (currentlyHeld != null):
			audio_stream_player.stream = pop_sound
			audio_stream_player.play()
			currentlyHeld = null
			print("released")

func spawn_customer(slot: int, dialogue_lines, dialogue_breakpoints, orders, customer_sprite: Texture, patience_in_seconds: float):
	var customer_instance = customer_scene.instantiate()
	var fixed_orders: Array[String] = []
	var fixed_dialogue_lines: Array[String] = []
	var fixed_dialogue_breakpoints: Array[int] = []

	for i in orders:
		fixed_orders.append(i)
	for i in dialogue_lines:
		fixed_dialogue_lines.append(i)
	for i in dialogue_breakpoints:
		fixed_dialogue_breakpoints.append(i)

	customer_instance.orders = fixed_orders
	customer_instance.dialogue_lines = fixed_dialogue_lines
	customer_instance.dialogue_breakpoints = fixed_dialogue_breakpoints
	customer_instance.get_child(0).texture_normal = customer_sprite
	customer_instance.used_slot = slot
	customer_instance.patience_in_seconds = patience_in_seconds
	customer_instance.on_all_orders_finished.connect(_on_order_finished)
	customer_instance.on_out_of_patience.connect(_on_order_patience_run_out)
	customer_instance.position.x = 255 + 620 * slot
	customer_instance.position.y = 475
	#print("spawned")
	add_child(customer_instance)
	move_child(customer_instance, 1)
	return customer_instance

# func _on_elapsed_timer_timeout():
# 	elapsed_time += 1
# 	print(elapsed_time)
# 	if (elapsed_time == 1):
# 		spawn_customer(
# 			0,
# 			["abc", "def"],
# 			[],
# 			["coconut"],
# 			load("res://sprites/customers/fish/fish1.png"),
# 			10
# 		)
# 		spawn_customer(
# 			1,
# 			["abc", "def"],
# 			[],
# 			["coconut"],
# 			load("res://sprites/customers/fish/fish1.png"),
# 			10
# 		)
# 		spawn_customer(
# 			2,
# 			["abc", "def"],
# 			[],
# 			["coconut"],
# 			load("res://sprites/customers/fish/fish1.png"),
# 			10
# 		)

func _on_order_finished(slot):
	#print("slot " + str(slot) + " is free")
	pass

func _on_order_patience_run_out(slot):
	#print("slot " + str(slot) + " out of patience")
	pass