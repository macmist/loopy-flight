extends Label

func _process(delta):
	if visible and Input.is_action_just_released("jump"):
		Signals.emit_signal("startplaneanim", "halfloop")
		queue_free()
