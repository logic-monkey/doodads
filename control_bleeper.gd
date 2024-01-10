extends AudioStreamPlayer2D
class_name ControlBleeper

var blip = preload("fauxbit-sounds/blip.wav")
var select = preload("fauxbit-sounds/select.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	bus = "effects input"
	#volume_db = linear_to_db(0.5)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	await get_tree().process_frame
	
	var bb = load("res://blackboard.tres")
	if bb:
		if "control_highlight_sound" in bb and bb.control_highlight_sound:
			blip = bb.control_highlight_sound
		if "control_activate_sound" in bb and bb.control_activate_sound:
			select = bb.control_activate_sound
	
	var c = get_parent() as Control
	if not c: return
	global_position = c.get_global_rect().get_center()
		
	c.focus_entered.connect(_on_owner_highlight)
	c.mouse_entered.connect(_on_owner_highlight)
	var b = c as BaseButton
	if b:
		c.pressed.connect(_on_owner_pressed)

func _on_owner_highlight():
	stop()
	stream = blip
	play()

func _on_owner_pressed():
	stop()
	stream = select
	play()
