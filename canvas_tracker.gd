extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	await  owner.ready
	offset = owner.global_position
func _process(delta):
	pass
