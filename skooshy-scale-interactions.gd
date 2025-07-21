extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pivot_offset = size/2
	scale= Vector2(0.8,0.8)
	mouse_entered.connect(on_highlight)
	mouse_exited.connect(on_dehighlight)
	focus_entered.connect(on_highlight)
	focus_exited.connect(on_dehighlight)

func expand():
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2.ONE, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	
func contract():
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(0.8,0.8), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

func on_highlight():
	expand()

func on_dehighlight():
	await get_tree().process_frame
	if has_focus(): return
	contract()
