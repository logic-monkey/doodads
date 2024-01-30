@tool
extends TextureButton
class_name CaptionedTextureButton

@export
var text: String:
	get:
		return %caption.text
	set(value):
		if not is_node_ready(): await ready
		%caption.text = value
		notify_property_list_changed()
		%caption.notify_property_list_changed()
		
@export var animation_length := 0.33
@export var fade_unless_hovered:= false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint(): return
	%caption_holder.modulate = Color.TRANSPARENT
	%caption_holder.position = Vector2.ZERO
	%caption_holder_holder.global_position = get_global_rect().get_center()
	if theme:
		%caption.theme = theme
	else:
		pass
	hide_caption()
	

func show_caption():
	var tween = get_tree().create_tween()
	tween.tween_property(%caption_holder, "modulate", Color.WHITE,animation_length)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel()
	tween.tween_property(%caption_holder, "position",\
			Vector2(0, get_global_rect().position.y - %caption_holder.global_position.y),animation_length )\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	
	if not fade_unless_hovered: return
	tween.tween_property(self, "modulate", Color.WHITE,animation_length)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
func hide_caption():
	var tween = get_tree().create_tween()
	tween.tween_property(%caption_holder, "modulate", Color.TRANSPARENT,animation_length)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel()
	tween.tween_property(%caption_holder, "position",\
			Vector2.ZERO, animation_length)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	
	if not fade_unless_hovered: return
	tween.tween_property(self, "modulate", Color(1,1,1,0.25),animation_length)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	


var caption_shown := false

func _on_focus_entered():
	if not caption_shown: show_caption()


func _on_focus_exited():
	if not has_focus(): hide_caption()
