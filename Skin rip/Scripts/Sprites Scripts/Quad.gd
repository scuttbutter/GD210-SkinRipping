extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

# Sprites for each screen quadrant
@export var top_left_sprite: Sprite2D
@export var top_right_sprite: Sprite2D
@export var bottom_left_sprite: Sprite2D
@export var bottom_right_sprite: Sprite2D

# Distance mouse must travel before triggering
@export var trigger_distance := 150.0

var clicked := false
var passed_point := false

# Which quadrant was clicked
var clicked_quadrant := ""

# Where the mouse was first clicked
var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture

	# Hide all quadrant sprites
	hide_sprite(top_left_sprite)
	hide_sprite(top_right_sprite)
	hide_sprite(bottom_left_sprite)
	hide_sprite(bottom_right_sprite)


func hide_sprite(sprite: Sprite2D):

	if sprite:
		sprite.visible = false


func determine_quadrant(mouse_pos: Vector2):

	var screen_size = get_viewport_rect().size

	var left_side = mouse_pos.x < screen_size.x / 2.0
	var top_side = mouse_pos.y < screen_size.y / 2.0

	if top_side and left_side:
		clicked_quadrant = "top_left"

	elif top_side and not left_side:
		clicked_quadrant = "top_right"

	elif not top_side and left_side:
		clicked_quadrant = "bottom_left"

	else:
		clicked_quadrant = "bottom_right"


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Click on this sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				# Determine clicked quadrant
				determine_quadrant(event.position)

				# Change to click texture
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

			# Show sprite based on quadrant
			match clicked_quadrant:

				"top_left":
					if top_left_sprite:
						top_left_sprite.visible = true

				"top_right":
					if top_right_sprite:
						top_right_sprite.visible = true

				"bottom_left":
					if bottom_left_sprite:
						bottom_left_sprite.visible = true

				"bottom_right":
					if bottom_right_sprite:
						bottom_right_sprite.visible = true
