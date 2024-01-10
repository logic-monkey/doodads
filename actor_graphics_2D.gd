extends Node2D
class_name ActorGraphics2D

@export var current_state = "idle"
var prior_state = "idle"

func _set_anim(state):
	$AnimationPlayer.play(state)

func _ready():
	_set_anim(current_state)
	
func spawn_dust_mote(start: Node2D, end: Node2D):
	if not has_node("/root/_PARTICLE"): return
	var particle = get_node("/root/_PARTICLE")
	var p = owner.get_parent()
	if not p: return
	var c = particle.dust()
	c.global_position = start.global_position
	p.add_child(c)
	var tween = get_tree().create_tween()
	tween.tween_property(c, "global_position", end.global_position, 0.5)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
signal animation_done
func play(state: String, direction = null):
	pass
