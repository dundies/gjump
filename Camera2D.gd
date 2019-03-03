extends Camera2D

onready var player = Utils.get_main_node().get_node("Player");

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	
	position = Vector2(player.position.x, position.y);
#	print(position.x);

func get_total_pos():
	return position + offset;