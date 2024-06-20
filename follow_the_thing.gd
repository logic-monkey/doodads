extends Node2D

@export var thing_to_follow: Node2D
@export var copy_rotation: bool  = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not thing_to_follow: return
	global_position = thing_to_follow.global_position
	if copy_rotation:
		global_rotation = thing_to_follow.global_rotation
