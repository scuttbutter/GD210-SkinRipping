extends AudioStreamPlayer

@export var track1: AudioStream
@export var track2: AudioStream
@export var track3: AudioStream

var current_track: AudioStream = null

func _process(_delta):
	var true_count = 0

	# Count GameState flags
	if GameState.left_passed: true_count += 1
	if GameState.right_passed: true_count += 1

	if GameState.top_left_passed: true_count += 1
	if GameState.top_right_passed: true_count += 1
	if GameState.bottom_left_passed: true_count += 1
	if GameState.bottom_right_passed: true_count += 1

	if GameState.top_passed: true_count += 1
	if GameState.bottom_passed: true_count += 1

	if GameState.top_left_leg_passed: true_count += 1
	if GameState.top_right_leg_passed: true_count += 1
	if GameState.bottom_left_leg_passed: true_count += 1
	if GameState.bottom_right_leg_passed: true_count += 1

	# Decide which track should play
	var new_track: AudioStream

	if true_count == 0:
		new_track = track1
	elif true_count == 1:
		new_track = track2
	elif true_count > 4:
		new_track = track3
	else:
		new_track = track2

	# Only change music if needed
	if new_track != current_track:
		current_track = new_track
		stream = current_track
		play()
