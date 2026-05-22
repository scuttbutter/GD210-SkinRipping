extends Node

# Existing
var left_passed := false
var right_passed := false

# New quadrant saves
var top_left_passed := false
var top_right_passed := false
var bottom_left_passed := false
var bottom_right_passed := false

var top_passed := false
var bottom_passed := false

var top_left_leg_passed := false
var top_right_leg_passed := false
var bottom_left_leg_passed := false
var bottom_right_leg_passed := false


func reset_data():

	left_passed = false
	right_passed = false

	top_left_passed = false
	top_right_passed = false
	bottom_left_passed = false
	bottom_right_passed = false

	top_passed = false
	bottom_passed = false

	top_left_leg_passed = false
	top_right_leg_passed = false
	bottom_left_leg_passed = false
	bottom_right_leg_passed = false
