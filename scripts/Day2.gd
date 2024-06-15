extends Timer

var elapsed_time = 0
var root

var sprites = [
	"res://sprites/customers/fish/fish1.png",
	"res://sprites/customers/fish/fish2.png",
	"res://sprites/customers/fish/fish3.png",
	"res://sprites/customers/fish/fish4.png",
	"res://sprites/customers/fish/fish5.png",
]

var dialogues = [
	["I’m so tired of my boss. ",
	"He works me to the bone and pays me the bear minimum. ",
	"I swear to the Crustacean Gods that I'm gonna quit one day.",],

	["It's a great sunny day today",
	"How are you feeling? I’m great!",
	"Man, I am so excited to eat!",],

	["Can you hurry up with my food?",
	"My kids are waiting and you DO NOT want to see them hangry.",
	"Can’t you work faster?!",
	"Do you even know what you’re doing?!",],

	["Is there any discount?",
	"I have a coupon. Can I use that?",
	"Is there any membership benefit?",
	"Is there a minimum order to get something extra?",],

	["This place is my FAVORITE!",
	"The food is just so great!",
	"I wish I could come here every single day.",
	"Especially that white meat, I still don’t know what they put in it to make it taste so good! Can you tell me what the secret recipe is?",],

	["Did you watch the surf competition yesterday?",
	"It was so exciting!",
	"In the end though Jessica got the best out of Edward…",
	"Edward was utterly left in the dust by her! ",],

	["This is the best vacation I have been on!",
	"I can’t wait to go to the water park tomorrow!",
	"Man, I need to get me one of those flower necklaces.",
	"I hope this vacation never ends!",],

	["No disturbances, just me, my book, and the sound of the sea.",
	"I’ve been waiting for weeks to read this new book.",
	"This author is just my favorite. The way she captures the moment is mesmerizing. ",],

	["There’s apparently a concert being held for the musician Catherine.",
	"It's her 4th album apparently and it's selling like hot cakes.",
	"Personally, I’m not a big fan of her genre. But, I can appreciate her talent in music.",],

	["Have you heard about what’s happening in the news?",
	"The world just keeps getting worse and worse.",
	"Please let things get better. I can't stand for all of this conflict anymore.",],

	["Tell Kayla to wait a bit longer, the food’s not done yet.",
	"Man, she’s gonna be upset.",
	"Can you go a little faster? I’m sorry but we’re really in a hurry. ",],
]

var customer_count = -1
var served_customers = 0
var customers = [
	#name, orders, patience_in_seconds, dialogue_lines, dialogue_breakpoints, customer_sprite
	
	["random", ["plate_tortilla_kelp", "plate_tortilla_kelp_mayo"],30],
	["random", ["plate_tortilla_meat"],30],
	["random", ["plate_tortilla_meat"],30],
	["random", ["plate_tortilla_meat_salsa", "coconut_umbrellablue"],30],
	["random", ["plate_tortilla_kelp_salsa", "coconut_umbrellapink", "coconut_umbrellapink"],30],
	["loansharkshark", [],10, ["LoanShark Shark: Hi, I hope you’re ready, I’ll come again in 2 days to pick up the money your Uncle has owed me."], [0],"res://sprites/customers/loansharkshark/sharkfrown.png"]
]
var animation_player
var audio_stream_player
var spawn_order

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_parent().get_node("AnimationPlayer")
	audio_stream_player = get_parent().get_node("AudioStreamPlayer")
	audio_stream_player.stream = load("res://sounds/music_gameplay1.mp3")
	audio_stream_player.finished.connect(_on_audio_stream_player_finished)
	audio_stream_player.play()

	animation_player.play("DayStart")
	root = get_parent()

	#manage initial spawning order
	
	#slot, time
	spawn_order = [0, 1, 2]
	
	randomize()
	spawn_order.shuffle()
	customers.shuffle() # randomize order of customers appearance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_random_customer(slot: int, orders, patience_in_seconds: int):
	#var dialogues = [a, b, c, d, e, f, g, h, i, j, k]
	var dialogue = dialogues.pick_random()
	var breakpoints = [dialogue.size() - 1]
	var sprite = sprites.pick_random()

	var customer_instance = root.spawn_customer(
			slot,
			dialogue,
			breakpoints,
			orders,
			load(sprite),
			patience_in_seconds
		)

	customer_instance.on_all_orders_finished.connect(_on_order_finished)
	customer_instance.on_out_of_patience.connect(_on_order_patience_run_out)

func spawn_customer(slot, dialogue, breakpoints, orders, sprite, patience_in_seconds):
	var customer_instance = root.spawn_customer(
			slot,
			dialogue,
			breakpoints,
			orders,
			load(sprite),
			patience_in_seconds
		)
	customer_instance.on_all_orders_finished.connect(_on_order_finished)
	customer_instance.on_out_of_patience.connect(_on_order_patience_run_out)

func _on_timeout():
	elapsed_time += 1

	#print(elapsed_time)
	if (elapsed_time == 5):
		next_customer(spawn_order[0])
	if (elapsed_time == 8):
		next_customer(spawn_order[1])
	if (elapsed_time == 12):
		next_customer(spawn_order[2])
	
		# root.spawn_customer(
		# 	0,
		# 	test,
		# 	breakpoints,
		# 	orders,
		# 	load("res://sprites/customers/fish/fish1.png"),
		# 	10
		# )
		# spawn_random_customer(0, ["coconut"])
		# spawn_random_customer(1, ["coconut"])
		# spawn_random_customer(2, ["coconut"])
		#next_customer(0)
		#next_customer(1)
		#next_customer(2)

func _on_order_finished(slot):
	print("slot " + str(slot) + " is free")
	served_customers += 1
	next_customer(slot)

var max_strikes = 4
var strike_count = 0
var canstrike = true
func _on_order_patience_run_out(slot):
	print("slot " + str(slot) + " out of patience")
	served_customers += 1
	strike_count += 1
	if (strike_count > max_strikes&&canstrike):
		animation_player.play("DayFailed")
		canstrike = false
		await get_tree().create_timer(8).timeout
		get_tree().reload_current_scene()
	else:
		next_customer(slot)

func next_customer(slot):
	var rand = RandomNumberGenerator.new().randf_range(2, 5)
	print(rand)
	await get_tree().create_timer(rand).timeout
	
	customer_count += 1
	if (customer_count >= customers.size()):
		end_day()
		print("out of customers")
	else:
		#if still has customers
		if (customers[customer_count][0] == "random"):
			spawn_random_customer(slot, customers[customer_count][1], customers[customer_count][2])
		else:
			spawn_customer(slot, customers[customer_count][3], customers[customer_count][4], customers[customer_count][1], customers[customer_count][5], customers[customer_count][2])

var has_ended = false
func end_day():
	if (!has_ended&&served_customers == customers.size()):
		has_ended = true
		animation_player.play("DayEnd")
		await get_tree().create_timer(6).timeout
		get_tree().change_scene_to_file("res://scenes/level3.tscn") # what do you want

func _on_audio_stream_player_finished():
	audio_stream_player.play()
