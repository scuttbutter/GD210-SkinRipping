extends Sprite2D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var old_mouse_pos = get_global_mouse_position()
			if event.button_index == MOUSE_BUTTON_LEFT:
				var dragging = false 
			var new_mouse_pos = get_global_mouse_position()
			# Move camera to keep the point under the mouse
			global_position += (old_mouse_pos - new_mouse_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
