extends Sprite2D

@export var idle_texture: Texture2D
@export var click_texture: Texture2D

@export var top_left_sprite_leg: Sprite2D
@export var top_right_sprite_leg: Sprite2D
@export var bottom_left_sprite_leg: Sprite2D
@export var bottom_right_sprite_leg: Sprite2D

@export var trigger_distance := 150.0

@onready var bg_music = $BGMusic
@onready var bg_music_2 = $BGMusic2
@onready var click_sound = $ClickSound


var clicked := false
var passed_point := false
var clicked_quadrant := ""
var click_position := Vector2.ZERO


func _ready():

	texture = idle_texture
	bg_music.play()

	# Hide all first
	hide_sprite(top_left_sprite_leg)
	hide_sprite(top_right_sprite_leg)
	hide_sprite(bottom_left_sprite_leg)
	hide_sprite(bottom_right_sprite_leg)

	# Restore saved states
	var gs = get_node("/root/GameState")

	if gs.top_left_passed and top_left_sprite_leg:
		top_left_sprite_leg.visible = true

	if gs.top_right_leg_passed and top_right_sprite_leg:
		top_right_sprite_leg.visible = true

	if gs.bottom_left_leg_passed and bottom_left_sprite_leg:
		bottom_left_sprite_leg.visible = true

	if gs.bottom_right_leg_passed and bottom_right_sprite_leg:
		bottom_right_sprite_leg.visible = true


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

			if event.pressed and get_rect().has_point(to_local(event.position)):

				clicked = true
				click_position = event.position

				determine_quadrant(event.position)

				if not passed_point:
					texture = click_texture
					fade_out_music()

			elif not event.pressed:

				clicked = false

				if not passed_point:
					texture = idle_texture


	if event is InputEventMouseMotion and clicked:

		var distance = click_position.distance_to(event.position)

		if not passed_point and distance >= trigger_distance:

			passed_point = true
			texture = click_texture
			
			await _handle_quadrant_success()

			var gs = get_node("/root/GameState")

			match clicked_quadrant:

				"top_left":

					gs.top_left_leg_passed = true

					if top_left_sprite_leg:
						top_left_sprite_leg.visible = true
						passed_point = false
						
						GameState.top_left_sprite_leg = true


				"top_right":

					gs.top_right_leg_passed = true

					if top_right_sprite_leg:
						top_right_sprite_leg.visible = true
						passed_point = false
						
						GameState.top_right_passed = true


				"bottom_left":

					gs.bottom_left_leg_passed = true

					if bottom_left_sprite_leg:
						bottom_left_sprite_leg.visible = true
						passed_point = false
						
						GameState.bottom_left_leg_passed = true


				"bottom_right":

					gs.bottom_right_leg_passed = true

					if bottom_right_sprite_leg:
						bottom_right_sprite_leg.visible = true
						passed_point = false
						
						GameState.bottom_right_leg_passed = true


func _handle_quadrant_success():

	click_sound.play()
	await click_sound.finished

	bg_music_2.play()

	texture = idle_texture


func fade_out_music():

	var tween = create_tween()
	tween.tween_property(bg_music, "volume_db", -80, 1.0)
	tween.tween_callback(bg_music.stop)
