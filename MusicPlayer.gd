extends Node
class_name MusicPlayer

@export var music:AudioStream
@export var play_on_load:= false
# Called when the node enters the scene tree for the first time.
func _ready():
	if play_on_load:
		_MUSIC.SwitchToSong(music)

func play():
	_MUSIC.SwitchToSong(music)
