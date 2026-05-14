extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D
@export var passed_texture: Texture2D

# Distance mouse must travel before changing texture
@export var trigger_distance := 150.0

var clicked := false
var passed_point := false

# Where the mouse was first clicked
var click_position := Vector2.ZERO

func _ready():
	texture = idle_texture

func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Click on sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):
				clicked = true
				click_position = event.position

				# Only show click texture if not already passed
				if not passed_point:
					texture = click_texture

			# Release mouse
			elif not event.pressed:
				clicked = false

				# Return to idle only if threshold not reached
				if not passed_point:
					texture = idle_texture

	if event is InputEventMouseMotion and clicked:

		# Distance from original click
		var distance = click_position.distance_to(event.position)

		# Change texture once distance is reached
		if not passed_point and distance >= trigger_distance:
			passed_point = true
			texture = passed_texture
