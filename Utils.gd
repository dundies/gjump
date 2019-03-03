extends Node


func _ready():

	pass

func get_main_node():
	var rootNode = get_tree().get_root();
	return rootNode.get_child(rootNode.get_child_count() - 1);