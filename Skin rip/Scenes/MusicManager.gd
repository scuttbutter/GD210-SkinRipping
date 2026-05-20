extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var current_track: AudioStream

var tracks = {
	"top_left": preload("res://music/top_left.ogg"),
	"top_right": preload("res://music/top_right.ogg"),
	"bottom_left": preload("res://music/bottom_left.ogg"),
	"bottom_right": preload("res://music/bottom_right.ogg"),
	"default": preload("res://music/default.ogg")
}

var fade_time := 1.5
var current_zone := "default"

func _process(delta):
	check_zones()

func check_zones():
	if GameState.top_left_passed and current_zone != "top_left":
		switch_music("top_left")

	elif GameState.top_right_passed and current_zone != "top_right":
		switch_music("top_right")

	elif GameState.bottom_left_passed and current_zone != "bottom_left":
		switch_music("bottom_left")

	elif GameState.bottom_right_passed and current_zone != "bottom_right":
		switch_music("bottom_right")
