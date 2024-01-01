extends AnimationPlayer
class_name AutoIdler

@export 
var idle_name: Array[String] = ["idle"]
@export_range(0.0, 3.0, 0.1, "or_greater")
var speed_variance : float = 0
@export 
var random_starting_point : bool = false


func _ready():
	animation_finished.connect(_on_animation_finished)
	_on_animation_finished(idle_name[0])


func _on_animation_finished(animation):
	if animation in idle_name:
		play(idle_name.pick_random(),-1,1.0 + randf_range(-speed_variance, speed_variance))
		if random_starting_point:
			seek(randf_range(0,0.75 * current_animation_length))
