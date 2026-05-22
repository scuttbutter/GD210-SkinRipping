extends Node2D

# Drag your sprites into these slots in the Inspector
@export var left_sprite: Sprite2D
@export var right_sprite: Sprite2D

@export var top_left_sprite: Sprite2D
@export var top_right_sprite: Sprite2D
@export var bottom_left_sprite: Sprite2D
@export var bottom_right_sprite: Sprite2D

@export var top_sprite: Sprite2D
@export var bottom_sprite: Sprite2D

@export var top_left_sprite_leg :Sprite2D
@export var top_right_sprite_leg : Sprite2D
@export var bottom_left_sprite_leg : Sprite2D
@export var bottom_right_sprite_leg : Sprite2D

# Scene to load when everything is completed
@export var next_scene_path : String = "res://Scenes/NextScene.tscn"

# Prevents scene from changing repeatedly
var scene_changed := false


func _process(delta):

	# Existing
	if left_sprite:
		left_sprite.visible = GameState.left_passed

	if right_sprite:
		right_sprite.visible = GameState.right_passed


	# Quadrants
	if top_left_sprite:
		top_left_sprite.visible = GameState.top_left_passed

	if top_right_sprite:
		top_right_sprite.visible = GameState.top_right_passed

	if bottom_left_sprite:
		bottom_left_sprite.visible = GameState.bottom_left_passed

	if bottom_right_sprite:
		bottom_right_sprite.visible = GameState.bottom_right_passed
		
		
	if top_sprite:
		top_sprite.visible = GameState.top_passed

	if bottom_sprite:
		bottom_sprite.visible = GameState.bottom_passed
		
		
		
	if top_left_sprite_leg:
		top_left_sprite_leg.visible = GameState.top_left_leg_passed

	if top_right_sprite_leg:
		top_right_sprite_leg.visible = GameState.top_right_leg_passed

	if bottom_left_sprite_leg:
		bottom_left_sprite_leg.visible = GameState.bottom_left_leg_passed

	if bottom_right_sprite_leg:
		bottom_right_sprite_leg.visible = GameState.bottom_right_leg_passed


	# Check if ALL globals are true
	if not scene_changed \
	and GameState.left_passed \
	and GameState.right_passed \
	and GameState.top_left_passed \
	and GameState.top_right_passed \
	and GameState.bottom_left_passed \
	and GameState.bottom_right_passed \
	and GameState.top_passed \
	and GameState.bottom_passed \
	and GameState.top_left_leg_passed \
	and GameState.top_right_leg_passed \
	and GameState.bottom_left_leg_passed \
	and GameState.bottom_right_leg_passed:

		scene_changed = true
		get_tree().change_scene_to_file(next_scene_path)
