extends KinematicBody2D

var STARTING_POINT = -100;
var MAX_LENGTH = 500;
var MIN_LENGTH = 150;
var PASS_AREA_LENGTH = 150;

var RECTANGLE_WIDTH = 100;
var color = Color(0,0,0);

var rectangles = Array();

signal destroyed;
onready var camera = Utils.get_main_node().get_node("Camera");
onready var player = Utils.get_main_node().get_node("Player");

enum {
	DOWNWARD,
	UPWARD
}

var MOVEMENT_VELOCITY_MAP = [100, -100];

var movementVerticalDirection;

#func generate(startingHorizontalPosition):
#	pass

func generate():
	
	randomize();
	var movement = randi()%(UPWARD + 1);
	
	movementVerticalDirection = MOVEMENT_VELOCITY_MAP[movement];
	
	var startingXPosition = 0;
	var startingHeightPosition;
	if (movement == UPWARD):
		startingHeightPosition = STARTING_POINT;
	else:
		startingHeightPosition = STARTING_POINT * 10;

	for rectangleToBeCreated in 7:
		randomize();
		var rectangleLength = rand_range(MAX_LENGTH, MIN_LENGTH);
		createRectangle(startingXPosition, startingHeightPosition, rectangleLength);
		startingHeightPosition = startingHeightPosition + rectangleLength + PASS_AREA_LENGTH;

	update();
	
func _input(event):
	pass

func _physics_process(delta):
	pass
#	print(position);


func _draw():
	
	for rect in rectangles:
		draw_rect(rect, color)

func createRectangle(startingXPosition, startingHeightPosition, rectangleLength):

	var extents = Vector2();
	extents.x = RECTANGLE_WIDTH/2;
	extents.y = rectangleLength/2;
	
	var collisionShape = CollisionShape2D.new()
	self.add_child(collisionShape);
#
	var box = RectangleShape2D.new();
	box.extents = extents
	collisionShape.shape = box;
	collisionShape.position.x = self.position.x + RECTANGLE_WIDTH / 2;
	collisionShape.position.y = startingHeightPosition + rectangleLength / 2;
	
	var rectangle = Rect2(self.position.x, startingHeightPosition, RECTANGLE_WIDTH, rectangleLength);
	
	rectangles.append(rectangle);
	
	

func _process(delta):
	move_and_slide(Vector2(0, movementVerticalDirection));
	if camera == null:
		return;
	
	if (rectangles[0]) :
		if self.position.x + rectangles[0].position.x + RECTANGLE_WIDTH  < camera.get_total_pos().x:
			queue_free();
			emit_signal("destroyed");
