extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

@export var top_passed_sprite: Sprite2D
@export var bottom_passed_sprite: Sprite2D

@export var trigger_distance := 150.0

@onready var bg_music = $BGMusic
@onready var bg_music_2 = $BGMusic2
@onready var click_sound = $ClickSound

var clicked := false
var passed_point := false
var clicked_top_side := false
var click_position := Vector2.ZERO


func _ready():
	texture = idle_texture

	bg_music.play()

	if GameState.top_passed:
		if top_passed_sprite:
			top_passed_sprite.visible = true

	if GameState.bottom_passed:
		if bottom_passed_sprite:
			bottom_passed_sprite.visible = true


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			# Mouse pressed on sprite
			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				var screen_height = get_viewport_rect().size.y
				clicked_top_side = event.position.y < screen_height / 2.0

				if not passed_point:
					texture = click_texture
					fade_out_music()

			# Mouse released
			elif not event.pressed:

				clicked = false

				if not passed_point:
					texture = idle_texture


	# Dragging while clicked
	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		if not passed_point and distance >= trigger_distance:

			passed_point = true
			texture = click_texture

			click_sound.play()
			await click_sound.finished

			bg_music_2.play()
			texture = idle_texture

			if clicked_top_side:

				GameState.top_passed = true

				if top_passed_sprite:
					top_passed_sprite.visible = true

			else:

				GameState.bottom_passed = true

				if bottom_passed_sprite:
					bottom_passed_sprite.visible = true

			passed_point = false


func fade_out_music():

	var tween = create_tween()
	tween.tween_property(bg_music, "volume_db", -80, 1.0)
	tween.tween_callback(bg_music.stop)
