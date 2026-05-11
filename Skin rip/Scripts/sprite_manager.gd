extends Node2D

@export var sprites: Array[NodePath]
 

func show_sprite(target: NodePath): 
	for path in sprites:
		get_node(path).visible = false # hiding all sprites 
		print(target)
		#to show specific sprite
		get_node(target).visible = true
 		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
