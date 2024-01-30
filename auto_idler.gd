## An Animation Player that immediately launches the "idle" animation when the
## game starts, and if there are multiple idle animations, picks between them.
extends AnimationPlayer
class_name AutoIdler

## List any idle animations you have here.
@export var idle_name: Array[String] = ["idle"]

## If true, each idle is less likely than the last.
@export var weighted_idles : bool = false

## If true, does not loop unless the animation is already looping.
@export var play_once : bool = false

## If true, plays at 7X speed if "p1_FF" is pressed.
@export var fast_forwardable : bool = false

## If higher than zero, the idle will play randomly faster or slower than the
## base animation by the specified amount.
@export_range(0.0, 3.0, 0.1, "or_greater")
var speed_variance : float = 0

## If true, the idle will start playing from a random point in the first 3/s of
## the animation.
@export 
var random_starting_point : bool = false

func _ready():
	randomize()
	animation_finished.connect(_on_animation_finished)
	_on_animation_finished(idle_name[0], true)


func _on_animation_finished(animation, override = false):
	if not animation in idle_name: return
	if play_once and not override: return
	if not weighted_idles:
		play(idle_name.pick_random(),-1,1.0 + randf_range(-speed_variance, speed_variance))
	else:
		var success := false
		for i in idle_name.size():
			if randi() % 3 != 0:
				success = true
				play(idle_name[i],-1,1.0 + randf_range(-speed_variance, speed_variance))
				break
		if not success:
			play(idle_name.pick_random(),-1,1.0 + randf_range(-speed_variance, speed_variance))
	if random_starting_point:
		seek(randf_range(0,0.75 * current_animation_length))
		
func _process(_delta):
	if not fast_forwardable: return
	if not is_playing(): return
	if current_animation_position < 1: return
	if Input.is_action_pressed("p1_FF"):
		speed_scale = 7.0
	if not Input.is_action_pressed("p1_FF"):
		speed_scale = 1.0
