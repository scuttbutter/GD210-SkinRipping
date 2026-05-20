extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

@export var left_passed_sprite: Sprite2D
@export var right_passed_sprite: Sprite2D

@export var trigger_distance := 150.0

var clicked := false
var passed_point := false
var clicked_left_side := false
var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture

	# Restore saved state
	if GameState.left_passed:
		if left_passed_sprite:
			left_passed_sprite.visible = true

	if GameState.right_passed:
		if right_passed_sprite:
			right_passed_sprite.visible = true


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				var screen_width = get_viewport_rect().size.x
				clicked_left_side = event.position.x < screen_width / 2.0

				if not passed_point:
					texture = click_texture

			elif not event.pressed:

				clicked = false

				if not passed_point:
					texture = idle_texture

	print(passed_point)
	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		if not passed_point and distance >= trigger_distance:

			passed_point = true
			texture = idle_texture

			if clicked_left_side:

				GameState.left_passed = true

				if left_passed_sprite:
					left_passed_sprite.visible = true
					passed_point = false

			else:

				GameState.right_passed = true

				if right_passed_sprite:
					right_passed_sprite.visible = true
					passed_point = false
