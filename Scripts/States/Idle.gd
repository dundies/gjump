extends "States.gd"

func enter():
	owner.gravity_scale = 0;
	owner.linear_velocity = Vector2(owner.SPEED, owner.linear_velocity.y);
	owner.get_node("AnimationPlayer").play("idle")

func exit():
	owner.gravity_scale = 5; #AUTOLOAD TODO
	
func update(delta):
	if Input.is_action_just_pressed("flap"):
		emit_signal("finished", "flying");
