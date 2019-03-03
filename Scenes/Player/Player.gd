extends RigidBody2D

onready var stateMap = {
	"idle": $States/Idle,
	"flying": $States/Flying
}

var currentState;

const SPEED = 200;
const JUMP_FORCE = 200;

func _ready():
	for state in $States.get_children():
		state.connect("finished", self, "_changeState");

	currentState = stateMap["idle"];
	currentState.enter();

func _physics_process(delta):
	currentState.update(delta);
	
func _changeState(stateName):
	currentState.exit();
	print("ballPosition" + str(position.x));
	currentState = stateMap[stateName];
	currentState.enter();
	
