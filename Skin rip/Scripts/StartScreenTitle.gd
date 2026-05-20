extends Sprite2D

func _ready():
	while true:

		# Fade out
		var tween_out = create_tween()
		tween_out.set_trans(Tween.TRANS_SINE)
		tween_out.set_ease(Tween.EASE_IN_OUT)

		tween_out.tween_property(
			self,
			"modulate:a",
			0.4,
			1.0
		)

		await tween_out.finished

		# Fade in
		var tween_in = create_tween()
		tween_in.set_trans(Tween.TRANS_SINE)
		tween_in.set_ease(Tween.EASE_IN_OUT)

		tween_in.tween_property(
			self,
			"modulate:a",
			1.0,
			1.0
		)

		await tween_in.finished
