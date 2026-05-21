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
