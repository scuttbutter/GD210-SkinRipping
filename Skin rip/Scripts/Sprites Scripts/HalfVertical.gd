extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

# Sprite shown if click started on LEFT side
@export var left_passed_sprite: Sprite2D

# Sprite shown if click started on RIGHT side
@export var right_passed_sprite: Sprite2D

# Distance mouse must travel before triggering
@export var trigger_distance := 150.0

var clicked := false
var passed_point := false

# Was the initial click on left side?
var clicked_left_side := false

# Where the mouse was first clicked
var click_position := Vector2.ZERO


func _ready():
	texture = idle_texture

	# Hide both sprites at start
	if left_passed_sprite:
		left_passed_sprite.visible = false

	if right_passed_sprite:
		right_passed_sprite.visible = false


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Click on this sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				# Determine if click began on left or right half of screen
				var screen_width = get_viewport_rect().size.x
				clicked_left_side = event.position.x < screen_width / 2.0

				# Show click texture only if not already passed
				if not passed_point:
					texture = click_texture

			# Mouse released
			elif not event.pressed:
				clicked = false

				# Return to idle if threshold not reached
				if not passed_point:
					texture = idle_texture


	if event is InputEventMouseMotion and clicked:

		# Distance from original click
		var distance = click_position.distance_to(event.position)

		# Trigger once
		if not passed_point and distance >= trigger_distance:

			passed_point = true

			# Return sprite back to idle texture
			texture = idle_texture

			# Show sprite based on which side was clicked
			if clicked_left_side:
				if left_passed_sprite:
					left_passed_sprite.visible = true
			else:
				if right_passed_sprite:
					right_passed_sprite.visible = true
