extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

# Sprites for top and bottom halves
@export var top_sprite: Sprite2D
@export var bottom_sprite: Sprite2D

# Distance mouse must travel before triggering
@export var trigger_distance := 150.0

var clicked := false
var passed_point := false

# Was the click in the top half?
var clicked_top := false

# Where the mouse was first clicked
var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture

	# Hide both sprites initially
	if top_sprite:
		top_sprite.visible = false

	if bottom_sprite:
		bottom_sprite.visible = false


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Click on this sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				# Determine top or bottom half
				var screen_height = get_viewport_rect().size.y
				clicked_top = event.position.y < screen_height / 2.0

				# Show click texture
				if not passed_point:
					texture = click_texture

			# Mouse released
			elif not event.pressed:

				clicked = false

				# Return to idle if threshold not reached
				if not passed_point:
					texture = idle_texture


	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		# Trigger once
		if not passed_point and distance >= trigger_distance:

			passed_point = true

			# Return to idle texture
			texture = idle_texture

			# Show correct sprite
			if clicked_top:
				if top_sprite:
					top_sprite.visible = true
			else:
				if bottom_sprite:
					bottom_sprite.visible = true
