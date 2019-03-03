extends "States.gd"

func enter():
	owner.get_node("AnimationPlayer").play("idle")


func update(delta):
	if Input.is_action_just_pressed("flap"):
		owner.linear_velocity = Vector2(owner.linear_velocity.x + 50, -owner.JUMP_FORCE);
#adding 20 for testing only
