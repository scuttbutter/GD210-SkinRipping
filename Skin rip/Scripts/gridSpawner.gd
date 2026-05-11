extends Node2D


@export var hitbox_scene: PackedScene
@export var columns: int = 10
@export var rows: int = 6
@export var spacing: Vector2 = Vector2(64, 64)
@export var offset: Vector2 = Vector2(32, 32)

func _ready():
	generate_grid()

func generate_grid():
	for x in columns:
		for y in rows:
			var hitbox = hitbox_scene.instantiate()
			
			hitbox.position = Vector2(
				x * spacing.x,
				y * spacing.y
			) + offset
			
			add_child(hitbox)
