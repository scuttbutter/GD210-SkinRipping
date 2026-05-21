extends Node

# Holds a reference to all audio files

var squash_file = "res://Music/Necrolysis Main Theme loopable.wav"
# and however many songs you want

var track_dict: Dictionary = { 
	"key": "value", 
	"squash": squash_file,
	"bgm1": "res://Music/Necrolysis Main Theme loopable.wav"
}

# tack_dict.squash

# Create a scene that will contain all the audio stream players
# Create X AudioStream nodes

# To play something, you can tell the audio stream node to play(track_dict.name_of_track)


# Create a function that cross fades between tracks
# function switch_tracks(new_track: String)
# fade out current track using a tween tweening volume_db
# fade in new track
