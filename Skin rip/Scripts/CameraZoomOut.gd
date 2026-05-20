extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = 0
	limit_top = 0
	limit_right = 1152
	limit_bottom = 1152

var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 1

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var old_mouse_pos = get_global_mouse_position()
			
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom.x = min(zoom.x + zoom_speed, max_zoom)
				zoom.y = min(zoom.y + zoom_speed, max_zoom)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom.x = max(zoom.x - zoom_speed, min_zoom)
				zoom.y = max(zoom.y - zoom_speed, min_zoom)
			
			# Ensure zoom stays proportional if needed (zoom.x = zoom.y)
			
			var new_mouse_pos = get_global_mouse_position()
			# Move camera to keep the point under the mouse
			global_position += (old_mouse_pos - new_mouse_pos)
			
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
