extends Area2D

@export var zoom_threshold := 2.0
@export var larger_than: bool = true
@export var scene_to_load: String
@export var camera: Node


var is_hovering := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	is_hovering = true
	
	
func _on_mouse_exited():
	is_hovering = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(is_hovering)
	
	if not is_hovering:
		return
	
	print(camera.zoom.x)
	

	if larger_than:
		if camera.zoom.x >= zoom_threshold:
			get_tree().change_scene_to_file(scene_to_load)
	elif not larger_than:
		if camera.zoom.x <= zoom_threshold:
			get_tree().change_scene_to_file(scene_to_load)
		
