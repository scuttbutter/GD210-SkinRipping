extends Sprite2D

@export var threshold0 := 500.0
@export var threshold1 := 1000.0
@export var threshold2 := 1100.0
@export var threshold3 := 1.0
@export var new_texture: Texture2D
@export var new_texture1: Texture2D

var tracking := false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		tracking = true
		
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_x = get_viewport().get_mouse_position().x
		
		if mouse_x > threshold0 and mouse_x < threshold1:
			texture = new_texture 
			tracking = false
		elif mouse_x > threshold1 and mouse_x < threshold2:
			texture = new_texture1 
			tracking = false
