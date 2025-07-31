@tool
extends Marker2D
class_name  SPLOSION_RING

# Splosion Ring disarmed for work on pixel art game.

@export var radius : float = 2.0:
	set(f): 
		if not Engine.is_editor_hint() and not is_node_ready(): await ready
		radius = f
		queue_redraw()
	get: return radius
	
@export var wait_time : float = 0.1

func _ready():
	if Engine.is_editor_hint(): return
	var t = Timer.new()
	t.wait_time = wait_time
	t.timeout.connect(_timer_timeout)
	add_child(t)
	t.start()
	_timer_timeout()
	
func _timer_timeout():
	var s = _PARTICLE.splosion()
	owner.get_parent().add_child(s)
#	s.position = Vector2.from_angle(randf_range(0, TAU)) * randf_range(0, radius * SharedPhysics.scale) + global_position
#	s.z_index = owner.z_index + 5
	
func _draw():
	if not Engine.is_editor_hint(): return
#	draw_circle(Vector2.ZERO,radius * SharedPhysics.scale, Color(RainbowRose.ORANGE, 0.25))
