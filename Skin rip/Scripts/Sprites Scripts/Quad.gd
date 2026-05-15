extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

# Sprite shown if click started on LEFT side
@export var left_passed_sprite: Sprite2D

# Sprite shown if click started on RIGHT side
@export var right_passed_sprite: Sprite2D

# Distance mouse must travel before triggering
@export var trigger_distance := 150.0

# Transition speed
@export var fade_time := 0.15

var clicked := false
var passed_point := false
var clicked_left_side := false

var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture

	# Hide passed sprites
	if left_passed_sprite:
		left_passed_sprite.visible = false
		left_passed_sprite.modulate.a = 0.0

	if right_passed_sprite:
		right_passed_sprite.visible = false
		right_passed_sprite.modulate.a = 0.0


func fade_to_texture(new_texture: Texture2D):

	var tween = create_tween()

	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, fade_time)

	# Change texture
	tween.tween_callback(func():
		texture = new_texture
	)

	# Fade back in
	tween.tween_property(self, "modulate:a", 1.0, fade_time)


func fade_in_sprite(sprite: Sprite2D):

	if not sprite:
		return

	sprite.visible = true
	sprite.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 1.0, fade_time)


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Click on sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				# Determine left/right side
				var screen_width = get_viewport_rect().size.x
				clicked_left_side = event.position.x < screen_width / 2.0

				# Fade to click texture
				if not passed_point:
					fade_to_texture(click_texture)

			# Mouse release
			elif not event.pressed:

				clicked = false

				# Return to idle if threshold not reached
				if not passed_point:
					fade_to_texture(idle_texture)


	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		# Trigger once
		if not passed_point and distance >= trigger_distance:

			passed_point = true

			# Fade back to idle
			fade_to_texture(idle_texture)

			# Show correct sprite
			if clicked_left_side:
				fade_in_sprite(left_passed_sprite)
			else:
				fade_in_sprite(right_passed_sprite)
