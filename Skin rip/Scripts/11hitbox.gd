extends Area2D

@export var normal_texture: Texture2D
@export var active_texture: Texture2D

@onready var sprite = 

var activated := false

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		activate()

func _on_mouse_entered():
	if InputManager.is_dragging:
		activate()

func activate():
	if activated:
		return
	
	activated = true
	sprite.texture = active_texture
