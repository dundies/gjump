extends Node2D

const scnObstacle = preload("res://Scenes/Obstacle.tscn");
onready var player = Utils.get_main_node().get_node("Player");
onready var camera = Utils.get_main_node().get_node("Camera");

const AMOUNT_TO_FILL_VIEW = 4;

const INITIAL_PLAYER_OBSTACLE_SEPARATION_WIDTH = 200;
const PLAYER_OBSTACLE_SEPARATION_WIDTH = 150;
 
func _ready():
	if player:
		print("player");
		player.currentState.connect("finished", self, "_onPlayerStateChanged", [], CONNECT_ONESHOT);
	pass

func _onPlayerStateChanged(stateName): #TODO refactor
	if stateName == "flying":
		generate();
	
func generate():
	for i in range (AMOUNT_TO_FILL_VIEW):
		if i == 0:
			moveAndSpawn(true);
		else:
			moveAndSpawn(false);

func spawn():
	randomize();
	var newObstacle = scnObstacle.instance();
	newObstacle.position = self.position;
	newObstacle.generate();
	newObstacle.connect("destroyed", self, "moveAndSpawn", [false]);
	get_node("Container").add_child(newObstacle);
	
func move(isInitial):
	var positionX = self.position.x;
	
	if camera && isInitial:
		positionX += camera.position.x;
	
	if isInitial:
		positionX += INITIAL_PLAYER_OBSTACLE_SEPARATION_WIDTH;
	else:
		positionX += PLAYER_OBSTACLE_SEPARATION_WIDTH;
		
	print("positionX is : " + str(positionX) + " ----- camera total position : " + str(camera.get_total_pos()));
	self.position = Vector2(positionX, 0); 

	
func moveAndSpawn(isInitial):
	move(isInitial);
	spawn();
	print("moveAndSpawn" + str(self.position.x));
