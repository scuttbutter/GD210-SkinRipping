extends Sprite2D

@export var idle_texture: Texture2D
#@export var click_texture: Texture2D

@export var left_passed_sprite: Sprite2D
@export var right_passed_sprite: Sprite2D

@export var click_texture: Texture2D

@export var trigger_distance := 150.0

@onready var bg_music = $BGMusic
@onready var bg_music_2 = $BGMusic2
@onready var click_sound = $ClickSound

var clicked := false
var passed_point := false
var clicked_left_side := false
var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture

	# Start first background music
	bg_music.play()

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

			# Mouse pressed on sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				var screen_width = get_viewport_rect().size.x
				clicked_left_side = event.position.x < screen_width / 2.0

				if not passed_point:
					texture = click_texture

					# Fade out first BG music
					fade_out_music()

			# Mouse released
			elif not event.pressed:

				clicked = false

				# Only reset if not triggered yet
				if not passed_point:
					texture = idle_texture


	# Dragging while clicked
	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		if not passed_point and distance >= trigger_distance:

			passed_point = true

			# Keep click texture visible
			texture = click_texture
			

			# Play click sound
			click_sound.play()

			# WAIT for sound to finish
			await click_sound.finished

			# Start second BG music
			bg_music_2.play()

			# Return texture to idle
			texture = idle_texture

			# Reveal correct sprite
			if clicked_left_side:

				GameState.left_passed = true

				if left_passed_sprite:
					left_passed_sprite.visible = true

			else:

				GameState.right_passed = true

				if right_passed_sprite:
					right_passed_sprite.visible = true

			passed_point = false


func fade_out_music():

	var tween = create_tween()

	# Fade volume to silent over 1 second
	tween.tween_property(bg_music, "volume_db", -80, 1.0)

	# Stop music after fade
	tween.tween_callback(bg_music.stop)
